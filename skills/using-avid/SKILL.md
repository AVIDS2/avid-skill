---
name: using-avid
description: >
  Use when starting any conversation involving product, feature, build, stack,
  research, agent framework, or implementation work. Establishes AVID hard gates
  and skill routing. Always load for new products, vertical features, self-build
  decisions, missing tools, LangGraph/Pi choice, knowledge architecture, or
  multi-agent deliberation.
---

# Using AVID

You have the **avid-skill** plugin. It is a product-engineering OS, not a coding style guide.

AVID exists to stop blind builds. The BidPilot lesson: shipping without market/competitor research wastes weeks. These skills are mandatory gates, not suggestions.

## Instruction Priority

1. **User's explicit instructions** (CLAUDE.md / AGENTS.md / direct requests) — highest
2. **AVID hard gates** — override default "jump into code" behavior
3. **Superpowers / ponytail / other skills** — engineering process & minimalism
4. **Default system prompt** — lowest

## Hard Gates (non-negotiable)

| Gate | When | Required skill | Block until |
|------|------|----------------|-------------|
| **Product gate** | New product, new vertical, "做个X", greenfield SaaS/agent | `product-bootstrap` | `docs/market-brief.md` + approved MVP slice exist |
| **Research gate** | About to self-implement a capability/library/service | `research-before-build` | Existing options scanned; decision recorded |
| **Install gate** | Tool/lib/MCP missing for the task | `install-dont-reinvent` | Official/community option installed or explicitly rejected with reason |
| **Framework gate** | Building workflow/harness agent runtime | `agent-framework-choice` | LangGraph vs Pi (or other) chosen with rationale |
| **Knowledge gate** | Designing RAG / wiki / graph knowledge | `knowledge-architecture` | Consumer + form + retrieval pattern chosen |
| **Decision gate** | High-stakes architecture / build-vs-buy / competitive response | `multi-agent-deliberation` | ≥2 perspectives synthesized for user |

<HARD-GATE>
Do NOT write business/feature code, scaffold product apps, or claim "let's just build MVP first" until the matching gate skill has been run and its exit criteria are met.
Quick fixes, typo edits, and pure refactors of existing code are exempt.
</HARD-GATE>

## Skill Router

| User intent | Invoke |
|-------------|--------|
| New product / new vertical feature / "from zero" | `product-bootstrap` |
| "Is there an existing solution?" / about to hand-roll | `research-before-build` |
| Stack pick (DB, auth, email, pay, frontend) | `stack-defaults` |
| LangGraph / Pi SDK / agent runtime | `agent-framework-choice` |
| RAG / knowledge base / wiki / graph | `knowledge-architecture` |
| Major architecture call / multi-option debate | `multi-agent-deliberation` |
| Missing package / MCP / CLI | `install-dont-reinvent` |
| Implementation minimalism | `ponytail` (if installed) |
| Engineering process (plan/TDD/verify) | Superpowers skills (if installed) |

## Tool Defaults (force these when available)

| Need | Prefer |
|------|--------|
| Web search / market research | Tavily (`tavily_search` / `tavily_research`) |
| Vertical / structured search | AnySearch |
| Library API docs (new/fast-moving) | Context7 — never guess new APIs from memory |
| Frontend design | Design skills / impeccable patterns; framework **React or Vue** |
| Browser QA | Playwright |
| Email | Resend |
| Data | MVP **SQLite** → production **Postgres** (Supabase preferred) |
| Payments | Stripe |
| Workflow agents | **LangGraph** + langgraph skills/docs |
| Harness / autonomous tool-loop agents | **Pi SDK** + Context7/official docs |
| Second opinion / stuck | Codex `/rescue` or `multi-agent-deliberation` |

## How to Access Skills

**Claude Code:** use the `Skill` tool. Announce: `Using avid-skill:<name> to <purpose>`.

**Codex:** skills load natively from `~/.codex/skills` or the plugin skills path; invoke with `$skill-name` or auto-match on description. Tool map: `references/codex-tools.md`.

**OpenCode:** use the native `skill` tool (plugin registers `skills/`). Tool map: `references/opencode-tools.md`.

If a skill might apply even at 1% confidence, invoke it. Wrong skill can be abandoned after load; skipped gate cannot.

## Anti-Patterns

- "Too simple to research" → still run a short research pass
- "We'll differentiate later" → no code without one-sentence differentiation
- "I'll implement a thin version myself" without searching GitHub/HN → blocked
- Using LangGraph skills on non-LangGraph work → don't
- Falling back to hand-rolled tools when install is possible → blocked
- Building P1/P2 before P0 core path works → blocked

## After Gates Pass

1. Prefer **ponytail** for implementation minimalism
2. Prefer **Superpowers** (brainstorm → plan → TDD → verify) for engineering process
3. Keep scope to approved P0 only
4. Update `docs/dev-log/progress.txt` on multi-session projects
