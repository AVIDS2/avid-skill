---
name: agent-framework-choice
description: >
  Use when choosing or implementing agent runtimes: LangGraph workflow agents,
  Pi SDK harness/autonomous tool-loop agents, multi-agent orchestration, or
  "which agent framework" decisions. Forces docs lookup (Context7/official) and
  correct skill pairing. Do NOT use for ordinary app features with no agent runtime.
---

# Agent Framework Choice

Pick the runtime that matches the control model. Then read current docs — never invent framework APIs from memory.

## Decision Tree

```text
Is the problem a stateful workflow with explicit nodes/edges,
human-in-the-loop, durable graph state, or branching business process?
  YES → LangGraph
  NO  → continue

Is the problem a coding/tool harness: model loop, tools, permissions,
sessions, autonomous multi-step tool use over a workspace?
  YES → Pi SDK (or the harness already in use: Claude Code / Codex)
  NO  → continue

Is it "just call an LLM + a few tools" with minimal state?
  YES → thin official SDK loop first (no heavy framework)
  NO  → multi-agent deliberation for custom orchestration
```

## LangGraph Path (workflow agents)

**Must:**

1. Invoke/use **langgraph-docs** / **langgraph-agent-patterns** skills when available
2. Otherwise Context7 or official LangGraph docs before coding
3. Model state schema, nodes, edges, persistence, HITL explicitly
4. Do **not** load LangGraph skills for non-LangGraph work

**Good fit:** bid pipelines, approval flows, multi-step research graphs, ETL-like agent pipelines.

## Pi SDK Path (harness / autonomous)

**Must:**

1. Fetch **current Pi official docs** via Context7 or web — core ideas first
2. Internalize: session, tools, permissions, prompts, loop — don't cargo-cult LangGraph patterns onto Pi
3. Prefer Pi's native extension points over reimplementing a graph layer on top

**Good fit:** local coding agents, computer-use style loops, repo-working autonomous agents.

## Docs Gate

<HARD-GATE>
No LangGraph or Pi implementation code until at least one fresh docs lookup this session (Context7 or official URL extract) for the APIs you will call.
</HARD-GATE>

## Output

Before coding, state:

```markdown
## Runtime choice
## Why this fits (3 bullets)
## Why not the other
## Docs consulted (links)
## Minimal skeleton plan
```

## Anti-Patterns

- Using LangGraph because "agents = graphs" for a simple tool loop
- Using Pi/harness patterns for a multi-day human approval workflow that needs durable graph state
- Mixing both frameworks in P0 without a boundary
- Copy-pasting outdated graph APIs from memory

## Related

- `stack-defaults`, `product-bootstrap`, `multi-agent-deliberation`
