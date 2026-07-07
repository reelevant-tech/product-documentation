# Developer Docs — Writing Guidelines

## Target Audience
Software engineers integrating Reelevant into their applications.
They have full technical knowledge: APIs, SDKs, servers, CI/CD.

## Tone & Style
- Direct, concise, technical
- Assume: proficiency with REST APIs, Node.js/TypeScript ecosystem,
  package managers, Git, CI/CD, server-side rendering
- Code-first: show the code, then explain
- Sentence length: up to 40 words (shorter is better)
- Avoid marketing language ("powerful", "seamless", "best-in-class")

## Vocabulary Rules
- Use precise technical terms (endpoint, payload, middleware, etc.)
- Use ALL platform vocabulary as canonical (Workflow, Datasource, etc.)
- Refer to the backend as "Runner" (not "engine" or "server")
- Package names: always exact npm names (`@rlvt/web-sdk`)

## Structure
- Start with a code example (the "hello world" of that feature)
- Use tabbed code blocks for multi-framework examples
- Document every parameter in tables (name, type, required, default, description)
- Include error scenarios and how to handle them
- Show request AND response for API examples
- End with "Related" links to other developer pages
- Use `<CodeGroup>` for language/framework variants

## Code Examples
- Always TypeScript (with JS alternative in tabs if relevant)
- Must be copy-pasteable (no pseudo-code, no `...` ellipsis)
- Include all imports
- Use realistic variable names (not `foo`, `bar`)
- Show error handling in at least one example per page

## Translation
- When editing any English page in this directory, check if `fr/developer-docs/<same-path>.mdx` exists.
  If it does, apply the same content change to the French file so it stays in sync.
- See the root `AGENTS.md` → "Translation / Internationalisation" section for full rules.

## What NOT to include
- UI screenshots (link to product-guide instead)
- Step-by-step UI instructions
- Marketing/sales language
- ROI or business value statements
