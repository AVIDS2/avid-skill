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

Opinionated defaults for AVID projects. Override only with a recorded reason.

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
| Workflow agents | **LangGraph** + langgraph skills/docs | See `agent-framework-choice` |
| Harness agents | **Pi SDK** + official/Context7 docs | See `agent-framework-choice` |
| Minimalism | **ponytail** | Lazier working solution |
| Process | **Superpowers** when installed | Plan/TDD/verify |
| Hosting (personal) | Existing VPS + Docker + reverse proxy pattern | Follow user infra notes |

## Decision Rules

1. **Repo wins**: if project already uses Vue/Next/Nuxt/etc., don't rewrite stack
2. **MVP data**: SQLite until multi-writer, need for managed auth, or clear prod path
3. **Managed beats yak-shave**: Supabase/Stripe/Resend over custom SMTP + homegrown billing
4. **Docs before code**: Context7 (or official docs) before using a new major API surface
5. **One frontend framework** per product surface — no React+Vue dual stacks without reason

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
