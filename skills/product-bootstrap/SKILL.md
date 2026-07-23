---
name: product-bootstrap
description: >
  Prefer before greenfield products, new verticals, or "做个X/从零做" work.
  Advisory research + grill-me + MVP cut. Strongly recommended to avoid blind
  builds, but not an absolute block if the user already has research/spec or
  explicitly wants a spike. Do NOT use for pure bugfixes/refactors.
---

# Product Bootstrap

Reduce BidPilot-class failures: building without research or a ruthless P0 cut.

## Strength: strongly recommended (still advisory)

Prefer this flow for new products/verticals. **You may skip or compress** when:

- User already provides solid research/spec and says to implement  
- Explicit spike / prototype with accepted throwaway risk  
- Tiny scoped experiment inside an existing product  

If you skip: one-line reason. Do not invent blockers to "look compliant."

## Suggested exit package (when you run the full flow)

1. Short market/competitor notes (or `docs/market-brief.md`) — aim ≥3 alternatives when research is feasible  
2. Differentiation in one sentence (or honest "no wedge yet")  
3. P0 / P1 / P2 cut — this iteration commits to P0  
4. Stack via `stack-defaults` (defaults, not handcuffs)  
5. User go-ahead on the package  

## Process (flexible order if user is fast)

1. **Grill-me** — who pays, job-to-be-done, 2-week success, out-of-scope (prefer few questions, not an interrogation)  
2. **Research** — Tavily + GitHub/HN as available; be blunt if a competitor dominates  
3. **MVP cut** — core loop only in P0  
4. **Stack confirm** — scene-aware (`agent-framework-choice` if agent runtime involved)  
5. **Plan handoff** — then implement  

## Anti-patterns

- Using bootstrap theater to delay a user-approved spike  
- Claiming "must not write any code" when user ordered a minimal PoC  
- Skipping research on a real greenfield product without saying so  
