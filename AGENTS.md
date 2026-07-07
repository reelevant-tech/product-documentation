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

## Translation / Internationalisation

This documentation is maintained in multiple languages. The English pages under each
directory are the **source of truth**. Translated versions live under `fr/` (French),
mirroring the same directory structure (e.g., `product-guide/workflows/overview.mdx` →
`fr/product-guide/workflows/overview.mdx`).

### Rules for contributors

1. **Every content change to an English page MUST be reflected in all existing
   translations.** When you add, edit, or delete content in an English `.mdx` file,
   check whether a corresponding file exists under `fr/` (and any future language
   directories). If it does, apply the same change to the translated file.
2. **New pages:** when you create a new English page, you do NOT need to create the
   translated version immediately — translations can be added in a later batch. But
   if a translated version already exists, it must stay in sync.
3. **Deleted pages:** if you delete an English page, delete its translated counterpart(s)
   as well.
4. **Structural changes:** if you rename or move an English file, rename/move the
   translated file to the same relative path under `fr/`.
5. **What to translate:** prose, headings, frontmatter `title` and `description` values,
   image alt text, and link display text. Keep unchanged: MDX/JSX component names and
   attributes, code blocks, URLs, canonical Reelevant product terms (Workflow, Datasource,
   Node, Content, DataHub, etc.), and UI button labels.
6. **Internal links in translations** must be prefixed with `/fr` so readers stay in the
   translated version (e.g., `/product-guide/workflows/overview` →
   `/fr/product-guide/workflows/overview`). Do NOT prefix external URLs or `api-reference`
   links.

### Currently available languages

| Prefix | Language |
|--------|----------|
| *(root)* | English (source of truth) |
| `fr/` | French (fr-FR) |

## Directory Ownership

| Directory | Primary Owner | Contributors |
|-----------|--------------|--------------|
| `product-guide/` | Customer Success (CS) | Product, TAM |
| `advanced-guide/` | Technical Account Managers (TAM) | CS, Engineering |
| `developer-docs/` | Engineering | TAM |
| `why-reelevant/` | Sales | Marketing, Product |
| `_glossary-internal.yaml` | Product (governance) | All teams |
