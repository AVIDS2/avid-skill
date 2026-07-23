# AVID (cross-tool)

If the **avid-skill** plugin (or its skills) is available, treat these as hard gates:

1. **New product / new vertical** → `product-bootstrap` before business code. Require market brief + P0 slice.
2. **About to self-build a capability** → `research-before-build`.
3. **Missing tool** → `install-dont-reinvent` (install; don't hand-roll silently).
4. **Stack choices** → `stack-defaults` (React/Vue, SQLite→Postgres/Supabase, Resend, Stripe, Playwright, Tavily, Context7).
5. **Agent runtime** → `agent-framework-choice` (LangGraph workflow + docs/skills; Pi SDK harness + official docs).
6. **Knowledge/RAG** → `knowledge-architecture`.
7. **High-stakes forks** → `multi-agent-deliberation` (or Codex second opinion).

Implementation defaults: minimal (ponytail if present), process (Superpowers if present). No pan-development: P0 only until core loop works.

Tool routing: Tavily (web), AnySearch (vertical), Context7 (lib APIs), Playwright (browser QA).
