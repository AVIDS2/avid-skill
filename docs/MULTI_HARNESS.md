# Multi-harness support (Claude Code · Codex · OpenCode)

One repo, three install surfaces. Skills (`skills/*/SKILL.md`) are shared; bootstrap differs per harness.

| Harness | Manifest / entry | Skills discovery | Always-on bootstrap |
|---------|------------------|------------------|---------------------|
| **Claude Code** | `.claude-plugin/plugin.json` + marketplace | plugin `skills/` | `hooks/SessionStart` → inject `using-avid` |
| **Codex** | `.codex-plugin/plugin.json` | `"skills": "./skills/"` or `~/.codex/skills` junctions | `~/.codex/AGENTS.md` AVID block |
| **OpenCode** | `package.json` main → `.opencode/plugins/avid-skill.js` | plugin `config.skills.paths` + optional junction | first-user-message inject via plugin |

## Install one-liner (this machine)

```powershell
# from clone
./scripts/install-all.ps1
```

```bash
./scripts/install-all.sh
```

## Per-harness manual

### Claude Code

```bash
claude plugin marketplace add AVIDS2/avid-skill
claude plugin install avid-skill@avid-skill
```

### Codex

```powershell
# skills junctions
./scripts/install-all.ps1   # Codex section

# or copy
# cp -r skills/* ~/.codex/skills/
```

Merge `AGENTS.md` snippet (script upserts marker block).

Optional plugin path: `~/.codex/plugins/avid-skill` → repo root (junction).

### OpenCode

```json
{
  "plugin": ["avid-skill@git+https://github.com/AVIDS2/avid-skill.git"]
}
```

Windows fallback: see `.opencode/INSTALL.md`.

## Versioning

Bump together: `package.json`, `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`, `.codex-plugin/plugin.json`.
