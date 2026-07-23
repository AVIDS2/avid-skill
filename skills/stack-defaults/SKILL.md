---
name: stack-defaults
description: >
  Use when choosing or confirming tech stack for a product or feature: frontend
  framework, database, auth, email, payments, hosting, search, or agent runtime.
  Applies AVID defaults (React/Vue, SQLite→Postgres/Supabase, Resend, Stripe,
  Playwright, Tavily, Context7) and records exceptions. Use during product-bootstrap
  or any greenfield/stack debate.
---

# Stack Defaults

Opinionated **defaults** for AVID projects. Easy to override — record a short reason when you do. Scene beats table.

## Default Stack Table

| Layer | Default | Notes |
|-------|---------|-------|
| Frontend | **React or Vue** | Match existing repo; greenfield prefer React+TS unless user is Vue-native |
| UI quality | Design skills / impeccable patterns | No generic AI slop UI |
| Web QA | **Playwright** | Prefer a11y snapshots over pure screenshots |
| Email | **Resend** | Transactional + registration flows |
| Payments | **Stripe** | Don't hand-roll billing |
| Data (MVP) | **SQLite** | Local/dev/single-node first |
| Data (prod) | **Postgres** via **Supabase** when it fits | Auth/storage/realtime optional |
| Search (web) | **Tavily** | Default research path |
| Search (vertical) | **AnySearch** | Domain/structured retrieval |
| Lib docs | **Context7** | New/fast-moving APIs — no memory guessing |
| Workflow agents | **LangGraph** + docs/skills | Only when workflow/HITL graph is real — see `agent-framework-choice` |
| Local harness agents | **Pi SDK / pi-ai / embed Pi** | Local/desktop/workspace agents only — **not** default for ordinary web FE/BE |
| **Model API protocol** (agent products) | **Chat Completions** `/v1/chat/completions` | Widest multi-model/gateway/Pi `openai-completions` support; Responses/Messages as optional extras |
| Minimalism | **ponytail** | Lazier working solution |
| Process | **Superpowers** on Claude Code when helpful | Not on Codex/OpenCode |
| Hosting (personal) | Existing VPS + Docker + reverse proxy pattern | Follow user infra notes |

## Decision Rules

1. **Repo / scene wins**: existing stack and deployment target override the table
2. **MVP data**: SQLite until multi-writer, managed auth need, or clear prod path
3. **Managed beats yak-shave** when it fits: Supabase/Stripe/Resend over custom SMTP + homegrown billing
4. **Docs before code** on fast-moving APIs (Context7 / official)
5. **One frontend framework** per product surface unless there's a real reason
6. **Agent runtime is scene-based** — never "always Pi" or "always LangGraph"
7. **Agent model wire protocol** — prefer Chat Completions for multi-provider; don't lock P0 to Responses-only unless product is OpenAI-only

## Exception Log Format

When overriding a default, record:

```markdown
- Layer: <e.g. email>
- Default: Resend
- Chosen: <X>
- Reason: <constraint>
```

Put exceptions in `docs/spec.md` or market/bootstrap package.

## Anti-Patterns

- Postgres-on-day-1 for a solo MVP with no multi-user load
- Custom payment state machines instead of Stripe
- Guessing LangGraph/Pi APIs without docs
- Installing both React and Vue "for flexibility"
- Building email sending with raw SMTP "to save money" without cost math

## Related

- `product-bootstrap`, `agent-framework-choice`, `install-dont-reinvent`
- `references/stack-table.md`
