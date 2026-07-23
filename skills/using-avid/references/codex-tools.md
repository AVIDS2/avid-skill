# Codex Tool Mapping (AVID)

Skills may use Claude Code tool names. On Codex, substitute:

| Skill references | Codex equivalent |
|------------------|------------------|
| `Skill` tool | Skills load natively — follow `SKILL.md` when matched / `$skill-name` |
| `Task` / Agent (subagent) | `spawn_agent` / `wait_agent` / `close_agent` if multi-agent enabled |
| `TodoWrite` / TaskCreate | `update_plan` |
| `Read` / `Write` / `Edit` | native file tools |
| `Bash` | native shell |
| Tavily MCP | use if configured in `~/.codex/config.toml` |
| Context7 MCP | use if configured |
| Playwright MCP | use if configured |
| Codex `/rescue` | native Codex second-opinion flows |

## Multi-agent (optional)

For `multi-agent-deliberation` parallel lenses:

```toml
[features]
multi_agent = true
```

## Install paths

Personal skills: `~/.codex/skills/<name>/SKILL.md`  
Plugin skills: via `.codex-plugin/plugin.json` `"skills": "./skills/"` when installed as a Codex plugin.

Global always-on rules: merge `AGENTS.md` from this repo into `~/.codex/AGENTS.md` (install script does a marker-block upsert).
