# OpenCode Tool Mapping (AVID)

| Skill references | OpenCode equivalent |
|------------------|---------------------|
| `Skill` tool | native `skill` tool |
| `Task` / Agent | OpenCode subagents / @mention |
| `TodoWrite` | `todowrite` |
| `Read` / `Write` / `Edit` / `Bash` | native tools |
| MCP (Tavily, Context7, Playwright) | as configured in `opencode.json(c)` |

Bootstrap: `.opencode/plugins/avid-skill.js` injects `using-avid` and adds this repo's `skills/` to `config.skills.paths`.
