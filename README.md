# AVID Skill

**Personal product-engineering OS for coding agents.**

Stops blind builds: market gates, grill-me specs, stack defaults, agent-framework choice, install-don't-reinvent.

Born from a real failure mode — shipping without competitor research (see: BidPilot vs later-discovered incumbents). AVID makes that failure a hard gate, not a postmortem.

## What's inside

| Skill | Role |
|-------|------|
| `using-avid` | Session router + hard gates (injected on SessionStart) |
| `product-bootstrap` | New product: research → grill-me → MVP cut → stack |
| `research-before-build` | Before self-building any capability |
| `stack-defaults` | React/Vue, SQLite→PG/Supabase, Resend, Stripe, … |
| `agent-framework-choice` | LangGraph vs Pi SDK + docs gate |
| `knowledge-architecture` | Human/agent/wiki/RAG/graph decision tree |
| `multi-agent-deliberation` | Multi-lens / Codex second opinions |
| `install-dont-reinvent` | Install official tools; no silent hand-roll |

Complements (does not replace): **Superpowers** (engineering process), **ponytail** (minimal implementation).

## Install (Claude Code)

### Option A — GitHub marketplace (recommended)

```bash
claude plugin marketplace add AVIDS2/avid-skill
claude plugin install avid-skill@avid-skill
```

Restart or open a new session. SessionStart injects `using-avid`.

### Option B — Local path (dev)

```bash
claude --plugin-dir /path/to/avid-skill
```

Or add marketplace from a local clone:

```bash
claude plugin marketplace add /path/to/avid-skill
claude plugin install avid-skill@avid-skill
```

### Option C — Scripts

Windows (PowerShell):

```powershell
./scripts/install.ps1
```

Unix:

```bash
./scripts/install.sh
```

## Verify

In a new Claude Code session:

- Skills should appear namespaced (e.g. `avid-skill:product-bootstrap`)
- Ask: "帮我做个新的标书 agent 产品" — agent should enter **product-bootstrap**, not scaffold code
- Ask: "自己写个邮件发送模块" — should hit **research-before-build** / Resend default

## Manual enable

If marketplace install is flaky, enable via settings `enabledPlugins`:

```json
{
  "enabledPlugins": {
    "avid-skill@avid-skill": true
  }
}
```

And ensure marketplace entry points at this repo (see `.claude-plugin/marketplace.json`).

## Layout

```text
avid-skill/
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── hooks/                 # SessionStart → inject using-avid
├── skills/                # SKILL.md packages
├── references/            # deep checklists (on-demand)
├── scripts/               # install helpers
├── AGENTS.md              # cross-tool constitution snippet
├── CLAUDE.md              # Claude-oriented pointer
└── README.md
```

## Cross-tool

- **Claude Code**: first-class plugin
- **Codex / others**: copy or symlink `skills/*` into `~/.agents/skills/` or `~/.codex/skills/`; merge `AGENTS.md` into global agents file

## Version

`0.1.0` — initial public packaging of AVID workflow.

## License

MIT
