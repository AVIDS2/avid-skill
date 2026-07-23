---
name: research-before-build
description: >
  MUST use before self-implementing a library, service, agent capability,
  scraper, auth system, billing flow, or any non-trivial subsystem. Searches
  GitHub, HN, and the web for existing OSS/SaaS/templates. Blocks hand-rolled
  builds when a mature option exists unless the user explicitly overrides with
  a recorded reason. Do NOT use for trivial glue code or project-local helpers.
---

# Research Before Build

Default: **find, don't found.**

<HARD-GATE>
Before writing a new subsystem from scratch, complete a research pass and state:
reuse / integrate / build. "Build" requires an explicit reason the existing options fail.
</HARD-GATE>

## When This Triggers

- New integration surface (email, pay, auth, storage, search, queue, agent tool)
- "We need our own X"
- Implementing something that sounds like a known product category
- Adding a capability that might already exist as MCP/skill/plugin

## Research Pass (time-boxed, evidence-based)

1. **Name the capability** in one line (e.g. "RFP/bid document generation agent")
2. **Search**
   - Tavily: `<capability> open source`, `<capability> SaaS`, alternatives
   - GitHub: keywords + sort by stars; note last commit, license, language
   - HN/Show HN via search when category is consumer/devtool
   - Existing skills/plugins/MCPs already on the machine (`find-skills`, plugin lists)
3. **Shortlist 3** options max for depth (more is noise)
4. **Score** each:

| Criterion | Weight |
|-----------|--------|
| Solves ≥80% of need | high |
| Maintained (commits / releases) | high |
| License OK for product | high |
| Fit with stack (TS/Python/etc.) | med |
| Ops burden | med |
| Cost | med |

5. **Decision**
   - **Reuse/integrate** (default if viable)
   - **Wrap/extend** existing
   - **Build** only if shortlist fails hard requirements

## Output

Write to chat (and `docs/research/<topic>.md` if multi-session):

```markdown
## Capability
## Options found
## Decision: reuse | wrap | build
## Why
## Sources
```

## Install Path

If reusing a tool/library not present → invoke `install-dont-reinvent`.

## Anti-Patterns

- Building a thinner worse OpenBidKit
- "Quick custom version" that becomes permanent
- Dismissing OSS for not being 100% fit when 80% + adapter works
- Research from model memory only (no tool calls)

## Related

- `product-bootstrap` for whole products
- `install-dont-reinvent` for missing tooling
- `multi-agent-deliberation` if build-vs-buy is contentious
