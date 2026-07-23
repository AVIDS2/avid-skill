# Installing AVID Skill for OpenCode

## Prerequisites

- [OpenCode.ai](https://opencode.ai) installed

## Installation

### Recommended — git-backed plugin

Add to the `plugin` array in `~/.config/opencode/opencode.json` or `opencode.jsonc` (global or project):

```json
{
  "plugin": ["avid-skill@git+https://github.com/AVIDS2/avid-skill.git"]
}
```

If you already have other plugins, append:

```json
{
  "plugin": [
    "opencode-goal-plugin",
    "opencode-notify",
    "avid-skill@git+https://github.com/AVIDS2/avid-skill.git"
  ]
}
```

Restart OpenCode. The plugin registers all AVID skills and injects `using-avid` on the first user message.

### Windows fallback (if git+https plugin install fails)

```powershell
npm install avid-skill@git+https://github.com/AVIDS2/avid-skill.git --prefix "$HOME\.config\opencode"
```

Then point the plugin at the local package:

```json
{
  "plugin": ["~/.config/opencode/node_modules/avid-skill"]
}
```

Or use the install script from a clone:

```powershell
./scripts/install-opencode.ps1
```

### Symlink skills only (no bootstrap injection)

```powershell
# PowerShell
$src = "E:\my_idea_cc\avid-skill\skills"   # or clone path
$dst = "$HOME\.config\opencode\skills\avid-skill"
New-Item -ItemType Junction -Path $dst -Target $src -Force
```

Without the JS plugin, add a short pointer in OpenCode instructions / AGENTS.md to load `using-avid` for product work.

## Verify

Ask OpenCode: "你有哪些 AVID skills？" or "帮我做个新产品，先走 bootstrap".

Expected: product-bootstrap / research gates, not immediate scaffolding.

## Tool mapping

| Skill says | OpenCode |
|------------|----------|
| Skill tool | native `skill` |
| TodoWrite | `todowrite` |
| Task / Agent | subagents / @mention |
| Read/Write/Edit/Bash | native tools |

## Updating

Clear OpenCode package cache or reinstall the git plugin if restarts don't pick up new commits. Pin a tag:

```json
{
  "plugin": ["avid-skill@git+https://github.com/AVIDS2/avid-skill.git#v0.2.0"]
}
```

## Getting help

- https://github.com/AVIDS2/avid-skill
