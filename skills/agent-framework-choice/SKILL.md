---
name: agent-framework-choice
description: >
  Use when choosing or implementing agent runtimes: LangGraph workflows, Pi /
  pi-ai / embedded Pi harness agents, thin provider SDK loops, or "which agent
  framework" decisions. Scene-based defaults — not a mandate to use Pi or
  LangGraph. Prefer docs lookup (Context7/official). Do NOT use for ordinary
  CRUD app features with no agent runtime.
---

# Agent Framework Choice

**Advisory decision aid.** Pick what fits the product surface. Do not force Pi SDK or LangGraph into every "agent" mention.

## First: name the scene

| Scene | Typical product | Runtime bias |
|-------|-----------------|--------------|
| **A. Web FE/BE / SaaS API** | Next/Vue + API, multi-user cloud app | Server-side agent code: thin SDK, or **LangGraph** if you need durable workflow/HITL graphs. **Pi SDK is usually a poor default** here. |
| **B. Local harness agent** | Electron/desktop agent, repo workspace agent, computer-use style | **Pi ecosystem**: Pi SDK, **pi-ai**, or embed/integrate a Pi agent — choose per docs and packaging needs |
| **C. Explicit business workflow graph** | Approvals, bid pipelines, multi-day stateful processes | **LangGraph** (+ langgraph skills/docs) |
| **D. Minimal tool chat** | Few tools, little state | Provider official SDK loop first — no heavy framework |

If unsure: state 2 options with scene fit, recommend one, let the user pick for irreversible choices.

## Decision tree (soft)

```text
What is shipping?
  Web FE/BE product without a local agent shell
    → do NOT default to Pi SDK
    → need durable graph / HITL / branching business process? LangGraph
    → else thin server-side LLM + tools SDK

  Local / desktop / workspace harness agent
    → Pi SDK or pi-ai or embedded Pi agent (read current docs)
    → not LangGraph unless you truly need a durable business graph

  Pure multi-step workflow product (cloud)
    → LangGraph first

  Tiny prototype
    → thinnest thing that works (ponytail)
```

## LangGraph path

When scene C (or A with real workflow needs):

1. Prefer langgraph-docs / langgraph-agent-patterns when available  
2. Else Context7 / official docs before coding  
3. Model state, nodes, edges, persistence, HITL explicitly  
4. Do not load LangGraph skills for non-LangGraph work  

## Pi / local harness path

When scene B:

1. Read **current** Pi / pi-ai docs (Context7 or official) — APIs change  
2. Choose packaging deliberately:  
   - **Pi SDK** — when you need the SDK integration model the docs describe  
   - **pi-ai** — when that package matches the stack  
   - **Embed / shell out to Pi agent** — when product should host or wrap the agent rather than re-implement the loop  
3. Do not cargo-cult LangGraph graphs onto Pi  
4. Do **not** recommend this path as default for ordinary web FE/BE  

## Thin SDK path

When scene D or early spike: official OpenAI/Anthropic/etc. SDK + tools. Promote to LangGraph/Pi only when pain appears (state, permissions, multi-agent, long sessions).

## Docs habit (strong suggestion, not a jail)

Before writing non-trivial framework code, do at least one fresh docs lookup this session for the APIs you will call. If you skip (spike / user said go), note that.

## Output before coding

```markdown
## Scene (A/B/C/D)
## Runtime choice
## Why this fits
## Why not the others (esp. if rejecting Pi or LangGraph)
## Docs consulted
## Risks if wrong
```

## Anti-patterns

- "Harness agent → must Pi SDK" on a cloud web app  
- "Agent → must LangGraph" for a 2-tool chatbot  
- Mixing Pi + LangGraph in P0 without a boundary  
- Coding from memory on fast-moving agent APIs  

## Related

- `stack-defaults`, `product-bootstrap`, `multi-agent-deliberation`
