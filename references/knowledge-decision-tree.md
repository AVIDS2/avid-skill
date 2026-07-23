# Knowledge Decision Tree

```text
Who reads it?
├─ Mostly humans → Wiki / Markdown nav, good headings
├─ Mostly agents → Chunkable source + metadata + stable IDs
└─ Both (default) → Human-editable source + agent indexes

Are relations the product?
├─ Yes, multi-hop entity questions → consider Knowledge Graph / Graph RAG
└─ No → documents + hybrid retrieval

Is single-shot retrieval enough?
├─ Yes → Hybrid (FTS + vector)
└─ No  → Agentic RAG (plan/retrieve/reflect)

Corpus size small (<~50 short docs)?
└─ Start with FTS + structure; add vectors when semantic miss rate hurts
```

MVP recommendation: **Markdown wiki + hybrid retrieval**, evaluate with 5 real questions before adding graphs or agentic layers.

See skill `knowledge-architecture`.
