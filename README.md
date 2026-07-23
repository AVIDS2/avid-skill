# AVID Skill

**Personal product-engineering OS for coding agents.**

Works on **Claude Code · Codex · OpenCode** from one repo.

Stops blind builds: market gates, grill-me specs, stack defaults, agent-framework choice, install-don't-reinvent.

Born from a real failure mode — shipping without competitor research. AVID makes that a hard gate, not a postmortem.

## What's inside

| Skill | Role |
|-------|------|
| `using-avid` | Session router + hard gates (injected on start where supported) |
| `product-bootstrap` | New product: research → grill-me → MVP cut → stack |
| `research-before-build` | Before self-building any capability |
| `stack-defaults` | React/Vue, SQLite→PG/Supabase, Resend, Stripe, Playwright, Tavily, Context7 |
| `agent-framework-choice` | LangGraph vs Pi SDK + docs gate |
| `knowledge-architecture` | Human/agent/wiki/RAG/graph decision tree |
| `multi-agent-deliberation` | Multi-lens / second opinions |
| `install-dont-reinvent` | Install official tools; no silent hand-roll |

Complements (does not replace): **Superpowers** (engineering process), **ponytail** (minimal implementation).

## Install — all three harnesses

From a clone (recommended on your machine):

```powershell
# Windows
./scripts/install-all.ps1
```

```bash
# Unix
./scripts/install-all.sh
```

Details: [docs/MULTI_HARNESS.md](docs/MULTI_HARNESS.md)

### Claude Code only

```bash
claude plugin marketplace add AVIDS2/avid-skill
claude plugin install avid-skill@avid-skill
```

### Codex only

```powershell
# junctions skills into ~/.codex/skills and ~/.agents/skills
# upserts AVID block into ~/.codex/AGENTS.md
./scripts/install-all.ps1
```

Or copy/symlink each folder under `skills/` into `~/.codex/skills/`.

Codex plugin manifest: [`.codex-plugin/plugin.json`](.codex-plugin/plugin.json).

### OpenCode only

Add to `~/.config/opencode/opencode.json` / `opencode.jsonc`:

```json
{
  "plugin": ["avid-skill@git+https://github.com/AVIDS2/avid-skill.git"]
}
```

Windows fallback and troubleshooting: [`.opencode/INSTALL.md`](.opencode/INSTALL.md).

## Verify

| Harness | Prompt |
|---------|--------|
| Any | 「帮我做个新的标书 agent 产品」 |
| Expected | Enters **product-bootstrap**, writes/asks research — **does not** scaffold business code first |

Claude: skills namespaced `avid-skill:…`  
Codex: `$product-bootstrap` or auto-match  
OpenCode: native `skill` tool lists AVID skills

## Layout

```text
avid-skill/
├── .claude-plugin/     # Claude Code marketplace + plugin.json
├── .codex-plugin/      # Codex plugin manifest
├── .opencode/          # OpenCode plugin + INSTALL.md
├── hooks/              # Claude SessionStart → using-avid
├── skills/             # shared SKILL.md packages
├── references/         # deep checklists
├── scripts/            # install-all / install.sh / install.ps1
├── docs/MULTI_HARNESS.md
├── AGENTS.md           # cross-tool constitution snippet
├── package.json        # OpenCode main entry
└── README.md
```

## Version

`0.2.0` — multi-harness (CC + Codex + OpenCode).

## License

MIT
