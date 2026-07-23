# AVID (cross-tool)

Personal product-engineering **defaults** for coding agents. Advisory — adapt to scene; user overrides win.

1. **New product / vertical** — prefer `product-bootstrap` (research + P0 cut). Compress/skip for approved spikes.
2. **Self-build a capability** — prefer `research-before-build`.
3. **Missing tool** — prefer `install-dont-reinvent` (install when practical).
4. **Stack** — `stack-defaults` as opinionated starting points, not handcuffs.
5. **Agent runtime** — `agent-framework-choice` **by scene**:
   - Web FE/BE / SaaS → do **not** default to Pi SDK; thin SDK or LangGraph only if workflow needs it
   - Local/desktop/workspace harness → Pi SDK / pi-ai / embed Pi as appropriate
   - Durable business workflow → LangGraph
6. **Model API protocol** (when building agent products) — prefer **Chat Completions** `/v1/chat/completions` for multi-model/gateway/Pi-compat; Responses/Messages optional extras unless single-vendor by design.
7. **Knowledge/RAG** — `knowledge-architecture` when designing knowledge systems.
8. **High-stakes forks** — optional `multi-agent-deliberation`.

Superpowers: **Claude Code only** (recommended, not mandatory). Codex/OpenCode: do not use Superpowers.
Implementation bias: minimal (ponytail), P0 first.
Tools: prefer Tavily, Context7, Playwright, official services — don't reimplement them inside AVID.

https://github.com/AVIDS2/avid-skill
