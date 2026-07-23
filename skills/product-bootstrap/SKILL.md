---
name: product-bootstrap
description: >
  MUST use before any new product, greenfield app, new vertical feature, or
  "做个X/从零做/新SaaS/新agent产品" work. Runs grill-me, market+competitor research,
  differentiation check, MVP prioritization, and stack confirmation. Hard-blocks
  business code until docs/market-brief.md and approved P0 slice exist. Do NOT use
  for pure bugfixes, refactors, or features inside an already-scoped product.
---

# Product Bootstrap

Prevent BidPilot-class failures: building without research, without forced questions, without a ruthless MVP cut.

<HARD-GATE>
Until exit criteria are met, do NOT:
- scaffold the product app
- write business/feature code
- set up production infra for the product
- invent a large feature list and start coding "the core later"

You MAY: search the web, read docs, write research/spec files, ask the user questions.
</HARD-GATE>

## Exit Criteria

All must be true before implementation skills/code:

1. `docs/market-brief.md` written (or user-approved equivalent path)
2. At least **3 competitors / alternatives** listed with sources
3. One-sentence **differentiation** the user accepted
4. **P0 / P1 / P2** cut; this iteration only commits to P0
5. Stack confirmed via `stack-defaults` (or explicit overrides recorded)
6. User said go on the bootstrap package

## Process (in order)

### 0. Announce
Say you are using `product-bootstrap` and will not write product code until gates pass.

### 1. Grill-me (questions, preferably one at a time)

Cover at least:

- Who pays / who uses? (may differ)
- What painful job is done today without you?
- What does success look like in 2 weeks vs 3 months?
- What is explicitly **out of scope**?
- Constraints: platform (web/electron/cli), region, budget, compliance
- Existing assets (domain, code, data, distribution)

Prefer multiple choice when possible. Do not dump 12 questions at once.

### 2. Market + competitor research (mandatory)

Use tools (do not invent from memory alone):

1. **Tavily research/search** — market, incumbents, pricing angles
2. **GitHub** — search keywords + trending-related repos (stars, last update, license)
3. **HN / launch archives** if relevant (via search)
4. Direct product sites for top hits (`tavily_extract` when needed)

Record in `docs/market-brief.md`:

```markdown
# Market Brief — <product>
Date: YYYY-MM-DD

## Problem
## Target user
## Alternatives (min 3)
| Name | Type (OSS/SaaS) | Stars/Traction | Positioning | Gap vs us |
## Why now
## Differentiation (1 sentence)
## Risks / kill criteria
## Sources
```

If a competitor "全方位吊打" the idea, **say so bluntly**. Offer: pivot, niche down, integrate, or stop — do not cheerlead.

### 3. Differentiation gate

User must accept a single sentence:

> For **[user]**, who **[problem]**, **[product]** is a **[category]** that **[key difference]** unlike **[alternative]**.

If this sentence is mush ("AI-powered better UX"), reject and rework.

### 4. MVP prioritization (no pan-development)

Force three buckets:

- **P0 — core loop only**: without this, product is not the product
- **P1 — soon**: valuable but not required to learn
- **P2 — later / never default**

Rules:

- P0 should be shippable as a thin vertical slice
- Auth/payment/email only enter P0 if the core loop cannot be validated without them
- No speculative platform-isms ("plugin system", "multi-tenant enterprise") in P0 unless that IS the product

Write `docs/spec.md` (or `docs/superpowers/specs/...` if Superpowers flow is active) with:

- Problem & user
- P0 user stories / acceptance checks
- Non-goals
- Stack decisions
- Open questions

### 5. Stack confirmation

Invoke or apply `stack-defaults`. Record choices and exceptions in the spec.

### 6. Plan handoff

Present bootstrap package:

1. Market brief summary (harsh if needed)
2. Differentiation sentence
3. P0/P1/P2 table
4. Stack
5. First implementation milestones (3–7 steps max)

Ask for explicit approval. On approval:

- If Superpowers available → `writing-plans` / plan skill
- Else → write a short step plan and only then implement P0

## Anti-Patterns

| Anti-pattern | Response |
|--------------|----------|
| "I already know the market" | Still do a time-boxed scan; attach sources |
| "Just build, research later" | Refuse product code; offer parallel research doc only |
| Feature laundry list as MVP | Cut to core loop |
| Cloning a 2k-star OSS with no wedge | Surface kill/pivot options |
| Skipping grill-me because user gave a long prompt | Extract assumptions; confirm the risky ones |

## Integration

- After bootstrap: implementation uses **ponytail** + Superpowers process when present
- Related: `research-before-build`, `stack-defaults`, `multi-agent-deliberation`
- Reference: `references/market-research-checklist.md`
