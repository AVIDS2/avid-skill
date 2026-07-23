---
name: using-avid
description: >
  Use when starting product, feature, build, stack, research, agent-framework,
  or implementation work. Loads AVID personal workflow defaults and skill routing.
  Defaults are advisory and scene-dependent — not absolute hard blocks. Skip or
  adapt when the deployment target or user intent makes a default a bad fit.
---

# Using AVID

You have the **avid-skill** plugin: a **personal product-engineering workflow**, not a replacement for official tools (Tavily, Context7, Playwright, Superpowers, etc.).

AVID exists to reduce blind builds and wrong defaults. It does **not** exist to force one stack/runtime into every project.

## Priority

1. **User's explicit instructions** — always highest  
2. **Scene fit / technical reality** — invalid defaults must be dropped (e.g. Pi on pure web FE/BE)  
3. **AVID suggested defaults** — prefer when they fit  
4. **Superpowers / ponytail** (when on Claude Code / when installed)  
5. Default system behavior  

## How to apply (important)

- Treat the table below as **recommended**, not court orders.
- When a skill fits: load it and follow the useful parts.
- When it doesn't: **skip or adapt**, and say one line why (scene mismatch / user override / cost).
- Never "comply" into a catastrophic wrong architecture just to satisfy a checklist.
- Tiny fixes, refactors, and already-scoped product work: no need to run bootstrap theater.

## Suggested routing

| Situation | Suggested skill | Notes |
|-----------|-----------------|-------|
| New product / new vertical / greenfield | `product-bootstrap` | Strongly recommended; still skippable if user already has research/spec |
| About to self-build a capability | `research-before-build` | Prefer find-before-found |
| Missing installable tool | `install-dont-reinvent` | Prefer install; hand-roll only with reason |
| Stack choice | `stack-defaults` | Defaults with easy exceptions |
| Agent runtime | `agent-framework-choice` | **Scene-based** — see below |
| Knowledge / RAG | `knowledge-architecture` | Clarify consumers first |
| High-stakes decision | `multi-agent-deliberation` | Optional second opinions |

## Agent runtime — scene fit (do not hard-force Pi)

| Scene | Prefer | Avoid forcing |
|-------|--------|----------------|
| Web FE/BE product, API, SaaS UI | Thin LLM SDK / server agent framework as needed; often **LangGraph** only if workflow/HITL graph is real | **Pi SDK as default** — wrong shape for normal web apps |
| Local coding / desktop / Electron / workspace harness agent | **Pi** family: Pi SDK, pi-ai, or embed/use Pi agent runtime — pick what docs + product need | LangGraph cargo-cult for a simple tool loop |
| Multi-step business workflow, durable state, HITL approvals | **LangGraph** + langgraph skills/docs | Pi-as-graph |
| "Just chat + a few tools" | Official provider SDK loop first | Heavy frameworks |

Always: fresh docs (Context7 / official) before coding on a chosen framework.

**Model API protocol (when building agents):** prefer **OpenAI Chat Completions** (`/v1/chat/completions`) for multi-model / gateway / Pi `openai-completions` compatibility. Treat Responses / Anthropic Messages as optional vendor paths — not the only P0 protocol unless the product is single-vendor by design. See `agent-framework-choice`.

## Tool defaults (prefer official tools)

| Need | Prefer |
|------|--------|
| Web research | Tavily |
| Vertical search | AnySearch |
| Lib docs | Context7 |
| Browser QA | Playwright |
| Email / pay / data | Resend / Stripe / SQLite→Postgres(Supabase) **when they fit** |
| Agent LLM wire protocol | **Chat Completions** first (multi-provider) |
| Minimal code | ponytail |
| Process (Claude Code) | Superpowers when helpful |

## Anti-patterns

- Blind build with zero market scan on a **new product** when research is cheap  
- Forcing Pi SDK because "AVID says harness → Pi" on a web platform where it doesn't apply  
- Forcing LangGraph on a trivial tool loop  
- Silent hand-roll of a mature hosted service without a reason  
- Ritual checklists that block a clearly scoped hotfix  

## After planning

Prefer minimal implementation; bias to P0. User can always say "skip AVID for this" — obey.
