---
name: multi-agent-deliberation
description: >
  Use for high-stakes decisions: architecture forks, build-vs-buy, competitive
  response, major refactors, or when the user wants multi-agent debate. Spawns
  diverse perspectives (or Codex second opinion) and synthesizes a recommendation.
  Do NOT use for trivial choices or every small implementation detail.
---

# Multi-Agent Deliberation

When a wrong call is expensive, don't mono-think. Force competing lenses, then decide.

## When to Use

- Build vs buy / build vs wrap competitor
- LangGraph vs Pi vs custom orchestration (after `agent-framework-choice` still unclear)
- "Should we pivot given competitor X?"
- Large rewrite vs incremental
- User explicitly asks for multi-agent or second opinion

## Procedure

### 1. Frame the decision

Write:

- Question (one sentence)
- Constraints (time, skills, stack, distribution)
- Success metric
- Deadline / reversibility (one-way door?)

### 2. Run 2–3 lenses (parallel when possible)

Pick lenses that disagree productively:

| Lens | Focus |
|------|--------|
| **User/value** | Does this help the buyer this month? |
| **Risk/security** | What fails in prod? |
| **Tech debt / YAGNI** | Simplest path (ponytail spirit) |
| **Competitive** | How does this position vs named alternatives? |
| **Codex/rescue** | Independent second implementation or review |

Implementation options:

- Claude Code `Agent` tool with distinct system prompts per lens
- Codex plugin `/rescue` or `/adversarial-review` when available
- Sequential self-roles only if subagents unavailable (label each role clearly)

### 3. Synthesize (you, main agent)

Produce:

```markdown
## Decision question
## Options
## Lens votes (table)
## Recommendation
## Dissent / residual risks
## What would change the decision
## Proposed next experiment (smallest test)
```

Do **not** average into mush. Pick a recommendation. Surface dissent.

### 4. User owns the call

Present synthesis; user confirms. Record in `docs/decisions/` or dev-log when multi-session.

## Anti-Patterns

- Five agents agreeing with the same prompt (fake diversity)
- Deliberating UI padding color
- Hiding the recommendation behind "it depends" with no default
- Skipping research gates by debating vibes only — attach evidence

## Related

- `product-bootstrap`, `research-before-build`, `agent-framework-choice`
