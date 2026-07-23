---
name: install-dont-reinvent
description: >
  Prefer when a required CLI, library, MCP, or skill is missing. Install official
  or best community option when practical. Advisory — hand-roll is allowed with
  an explicit reason (license, abandoned, fundamental mismatch, user order).
---

# Install, Don't Reinvent

Bias: missing capability → **try install first**. Hand-rolled fallbacks are OK when justified — not silent permanent forks of mature tools.

## Procedure

1. Name the need  
2. Find install candidates (official docs, plugin/skill marketplaces, npm/pip)  
3. Install + smoke verify when feasible  
4. If building instead: state why (license / abandoned / wrong platform / user override)

## Anti-patterns

- Silent weaker reimplementation when install is one command  
- Blocking the user for hours over an optional tool  
