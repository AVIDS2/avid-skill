---
name: knowledge-architecture
description: >
  Use when designing knowledge bases, RAG, wiki, knowledge graphs, memory for
  agents, or "how should we store docs for humans vs agents". Produces a clear
  consumer/form/retrieval decision. Avoids buzzword soup. Do NOT use for ordinary
  app CRUD databases.
---

# Knowledge Architecture

Separate three decisions people often mash together: **who consumes**, **what form**, **how retrieval works**.

## Step 1 — Who consumes?

| Consumer | Optimize for |
|----------|----------------|
| **Humans** | Readable structure, navigation, editability (Wiki / Markdown tree) |
| **Agents** | Chunkability, metadata, stable IDs, tool-friendly retrieval |
| **Both (default for products)** | Single source of truth humans edit + indexes agents query |

Default bias: **coexistence** — humans write Markdown/Wiki; agents get hybrid retrieval over the same source. Avoid a second shadow knowledge base unless required.

## Step 2 — What form?

| Form | When |
|------|------|
| **Markdown / Wiki** | Most products; docs, runbooks, specs |
| **Structured DB records** | Strong schema entities (tickets, SKUs) |
| **Knowledge graph** | Relationships are first-class (org charts, law cites, multi-hop entity links) |
| **Vector-only corpus** | Large unstructured dump with weak structure needs |

MVP default: **Markdown wiki (or `/docs`)**. Promote to graph when queries are relationship-heavy and hybrid RAG fails.

## Step 3 — Retrieval pattern

| Pattern | When |
|---------|------|
| Full-text only | Small corpus, precise keywords |
| Vector RAG | Semantic questions over unstructured text |
| **Hybrid** (keyword + vector) | Default production RAG |
| **Agentic RAG** | Multi-step: plan → retrieve → critique → retrieve again |
| Graph RAG | Multi-hop entity/relation questions |

MVP default: **hybrid retrieval**. Use agentic RAG when single-shot retrieval quality is measurably insufficient.

## Decision Output

```markdown
## Consumers: human | agent | both
## Source form: markdown-wiki | db | graph | mixed
## Retrieval: fts | vector | hybrid | agentic | graph-rag
## Ingestion path
## Evaluation plan (5 real questions the system must answer)
## Non-goals
```

## Anti-Patterns

- "We need a knowledge graph" with no multi-hop questions
- Separate Notion for humans + random vectors for agents with no sync
- Agentic RAG theater on a 20-page corpus
- Building custom RAG platform instead of using mature components (research-before-build)

## Related

- `research-before-build`, `stack-defaults`
- `references/knowledge-decision-tree.md`
