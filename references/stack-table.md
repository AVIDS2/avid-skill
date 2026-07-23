# AVID Stack Table (quick reference)

| Layer | Default | Escalate when |
|-------|---------|----------------|
| UI framework | React or Vue | Repo already chose otherwise |
| Design | design skills / impeccable | Brand system exists |
| E2E | Playwright | — |
| Email | Resend | Enterprise relay mandated |
| Pay | Stripe | Region without Stripe + approved alt |
| DB MVP | SQLite | Multi-writer early |
| DB prod | Postgres (Supabase) | Existing PG/provider |
| Web research | Tavily | — |
| Vertical search | AnySearch | — |
| API docs | Context7 | Official-only libs |
| Workflow agent | LangGraph + skills/docs | — |
| Harness agent | Pi SDK + docs | Claude Code/Codex is the product |
| Minimal code | ponytail | — |
| Process | Superpowers | User forbids |

Full rules: skill `stack-defaults`.
