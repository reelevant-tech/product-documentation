# Documentation Contribution Guidelines

## Global Rules (apply to ALL directories)

### Terminology
- ALWAYS reference `_glossary-internal.yaml` before writing any page.
- Use ONLY the `canonical_name` for each concept. NEVER use `synonyms_forbidden`.
- Platform concepts (Workflow, Datasource, Content, Node, Branch, Channel, Output Node,
  Data Node, Logic Node, DataHub, etc.) are NEVER renamed, simplified, or paraphrased
  regardless of the target audience.
- A "low maturity" user still learns the real product vocabulary — we explain concepts
  more simply but we do NOT rename them.

### Formatting
- Links: Use relative Mintlify paths (e.g., `/product-guide/workflows/overview`).
  Cross-persona links are allowed and encouraged.
- Images: Store in `/images/{section}/`. Use descriptive alt text.
- Frontmatter: Every page MUST have `title` and `description` in YAML frontmatter.
- Language: English (UK spelling: "personalisation", "behaviour", "colour").

### Cross-referencing
- If a concept is defined in the glossary, link to `/glossary` rather than re-defining inline.
- Link to other persona directories when appropriate (e.g., product-guide links to
  advanced-guide for deeper configuration).

### Content Duplication
- Each persona directory is independently maintained.
- The same topic MAY exist in multiple directories at different depth levels.
- Each version is written for its target audience — NOT copy-pasted.

## Directory Ownership

| Directory | Primary Owner | Contributors |
|-----------|--------------|--------------|
| `product-guide/` | Customer Success (CS) | Product, TAM |
| `advanced-guide/` | Technical Account Managers (TAM) | CS, Engineering |
| `developer-docs/` | Engineering | TAM |
| `why-reelevant/` | Sales | Marketing, Product |
| `product-adoption/` | CS + TAM (joint) | Sales, Product |
| `_glossary-internal.yaml` | Product (governance) | All teams |
