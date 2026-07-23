---
name: install-dont-reinvent
description: >
  MUST use when a required CLI, library, MCP server, skill, or plugin is missing.
  Install the official or best community option in-session. Forbids silent
  fallback to a hand-rolled weaker implementation. Use whenever tempted to
  "just write a quick version ourselves" for tooling that exists.
---

# Install, Don't Reinvent

Missing capability → **install first**. Hand-rolled fallbacks are last resort and must be explicit.

<HARD-GATE>
If a mature installable tool exists for the job, do not reimplement it "temporarily" without user-visible reason and a tracked removal plan.
</HARD-GATE>

## Procedure

1. **Name the need** (one line)
2. **Find install candidates**
   - Official docs / package name
   - Claude plugin marketplace / skills (`find-skills`)
   - MCP servers
   - npm / pip / gh releases
3. **Prefer**
   - Official > maintained popular community > obscure
   - Already in user's stack (they have Tavily, Playwright, etc.)
4. **Install** with the platform-appropriate method
5. **Verify** (`--version`, smoke call, or import)
6. **Use it** in the task

## When Build Is Allowed

Only if:

- No acceptable license
- Abandoned / insecure with no alternative
- Fundamental mismatch (wrong platform)
- User explicitly orders a custom build after hearing options

Then: record reason; keep surface area minimal (ponytail).

## Anti-Patterns

- Reimplementing web search when Tavily exists
- Custom browser automation when Playwright MCP/skill exists
- Home-grown email stack when Resend is the default
- Copy-pasting 200 lines of SDK wrapper instead of installing the official CLI
- Silent degradation ("tool failed so I wrote a mock")

## Related

- `research-before-build`, `stack-defaults`
