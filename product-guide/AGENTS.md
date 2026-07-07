# Product Guide — Writing Guidelines

## Target Audience
Marketers and campaign managers with LOW data/technical maturity.
They use the Reelevant platform UI. They do not write code.

## Tone & Style
- Friendly, encouraging, accessible
- Use "you" voice: "You can create a Workflow by..."
- Assume NO prior knowledge of data concepts, APIs, or programming
- Maximum sentence length: 25 words
- Maximum paragraph length: 3 sentences
- EXPLAIN concepts simply but NEVER rename them (a Node is always a "Node")

## Vocabulary Rules
- ALWAYS use official platform terminology (Node, Workflow, Datasource, Branch, etc.)
- When introducing a concept for the first time on a page, add a brief plain-language
  explanation in parentheses: "Add a Data Node (a step that fetches external data)"
- NEVER use: API, SDK, endpoint, payload, JSON, schema, query (SQL sense),
  runtime, server-side, client-side, middleware, webhook
- Use UI labels exactly as they appear in the product

## Structure
- Start every page with a 1-sentence summary of WHAT this feature does
- Use screenshots liberally (1 per major section minimum)
- Use numbered step-by-step lists for procedures
- Use tables for comparing options
- End pages with "What's Next?" cards linking to logical next steps
- Use `<Tip>` for pro-tips, `<Warning>` for destructive actions

## Translation
- When editing any English page in this directory, check if `fr/product-guide/<same-path>.mdx` exists.
  If it does, apply the same content change to the French file so it stays in sync.
- See the root `AGENTS.md` → "Translation / Internationalisation" section for full rules.

## What NOT to include
- Code snippets (none, ever)
- API endpoints or HTTP methods
- Technical architecture details
- Performance/scaling information
- Anything requiring terminal/CLI usage
