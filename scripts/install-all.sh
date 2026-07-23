#!/usr/bin/env bash
# Install avid-skill for Claude Code + Codex + OpenCode (Unix)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS="$ROOT/skills"
HOME_DIR="${HOME}"

echo "==> avid-skill root: $ROOT"

link_skill_dirs() {
  local dest_root="$1"
  mkdir -p "$dest_root"
  for d in "$SKILLS"/*/; do
    [ -d "$d" ] || continue
    name="$(basename "$d")"
    target="$dest_root/$name"
    if [ -L "$target" ] || [ -d "$target" ]; then
      rm -rf "$target"
    fi
    ln -s "$d" "$target"
    echo "    linked $target"
  done
}

upsert_agents() {
  local path="$1"
  local start="<!-- AVID-SKILL-START -->"
  local end="<!-- AVID-SKILL-END -->"
  local block
  block=$(cat <<EOF
$start
## AVID Skill (cross-tool)

If AVID skills are available, hard gates apply:

1. New product / new vertical → \`product-bootstrap\` before business code.
2. Self-build a capability → \`research-before-build\`.
3. Missing tool → \`install-dont-reinvent\`.
4. Stack → \`stack-defaults\`.
5. Agent runtime → \`agent-framework-choice\`.
6. Knowledge/RAG → \`knowledge-architecture\`.
7. High-stakes forks → \`multi-agent-deliberation\`.

Source: https://github.com/AVIDS2/avid-skill
$end
EOF
)
  mkdir -p "$(dirname "$path")"
  if [ ! -f "$path" ]; then
    printf '%s\n' "$block" >"$path"
    echo "    created $path"
    return
  fi
  if grep -q "$start" "$path"; then
    # portable-ish rewrite via temp
    python3 - "$path" <<'PY' || true
import re,sys
path=sys.argv[1]
text=open(path,encoding='utf-8').read()
start='<!-- AVID-SKILL-START -->'
end='<!-- AVID-SKILL-END -->'
block='''<!-- AVID-SKILL-START -->
## AVID Skill (cross-tool)

If AVID skills are available, hard gates apply:

1. New product / new vertical → `product-bootstrap` before business code.
2. Self-build a capability → `research-before-build`.
3. Missing tool → `install-dont-reinvent`.
4. Stack → `stack-defaults`.
5. Agent runtime → `agent-framework-choice`.
6. Knowledge/RAG → `knowledge-architecture`.
7. High-stakes forks → `multi-agent-deliberation`.

Source: https://github.com/AVIDS2/avid-skill
<!-- AVID-SKILL-END -->'''
pat=re.compile(re.escape(start)+r'.*?'+re.escape(end), re.S)
if pat.search(text):
    text=pat.sub(block,text)
else:
    text=text.rstrip()+'\n\n'+block+'\n'
open(path,'w',encoding='utf-8').write(text)
print('    updated', path)
PY
  else
    printf '\n%s\n' "$block" >>"$path"
    echo "    appended $path"
  fi
}

echo "==> Claude Code"
claude plugin marketplace add "$ROOT" 2>/dev/null || true
claude plugin marketplace add AVIDS2/avid-skill 2>/dev/null || true
claude plugin install avid-skill@avid-skill -s user || echo "    Claude install failed — use --plugin-dir $ROOT"

echo "==> Codex"
link_skill_dirs "$HOME_DIR/.codex/skills"
link_skill_dirs "$HOME_DIR/.agents/skills"
upsert_agents "$HOME_DIR/.codex/AGENTS.md"
mkdir -p "$HOME_DIR/.codex/plugins"
rm -rf "$HOME_DIR/.codex/plugins/avid-skill"
ln -s "$ROOT" "$HOME_DIR/.codex/plugins/avid-skill" 2>/dev/null || true

echo "==> OpenCode"
OC="$HOME_DIR/.config/opencode"
mkdir -p "$OC/skills" "$OC/plugins"
rm -rf "$OC/skills/avid-skill"
ln -s "$SKILLS" "$OC/skills/avid-skill"
cp -f "$ROOT/.opencode/plugins/avid-skill.js" "$OC/plugins/avid-skill.js"
upsert_agents "$OC/AGENTS.md"

CFG=""
[ -f "$OC/opencode.jsonc" ] && CFG="$OC/opencode.jsonc"
[ -z "$CFG" ] && [ -f "$OC/opencode.json" ] && CFG="$OC/opencode.json"
if [ -n "$CFG" ]; then
  if ! grep -q 'avid-skill' "$CFG"; then
    echo "    Add to $CFG plugin array:"
    echo '      "avid-skill@git+https://github.com/AVIDS2/avid-skill.git"'
  else
    echo "    $CFG already mentions avid-skill"
  fi
else
  cat >"$OC/opencode.json" <<EOF
{
  "\$schema": "https://opencode.ai/config.json",
  "plugin": ["avid-skill@git+https://github.com/AVIDS2/avid-skill.git"],
  "skills": { "paths": ["$SKILLS"] }
}
EOF
  echo "    wrote $OC/opencode.json"
fi

echo "==> Done. Restart all agent sessions."
