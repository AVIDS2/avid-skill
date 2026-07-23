# AVID Skill (Claude Code)

This repository is a Claude Code plugin. Prefer installing via marketplace; do not duplicate these rules into every project CLAUDE.md.

SessionStart injects `skills/using-avid/SKILL.md`. Other skills load on demand via the Skill tool.

When developing this plugin itself:

- Keep `using-avid` short enough for SessionStart injection
- Put long checklists under `references/`
- Bump version in `.claude-plugin/plugin.json` and `marketplace.json` together
