# Claude Code — Project Instructions

## What This Repo Is

Reelevant product documentation built with [Mintlify](https://mintlify.com). Five directories target different audience personas. Each directory has its own `AGENTS.md` with strict writing rules — **read the AGENTS.md in the directory you are editing before making any changes**.

## Mandatory Terminology

Before writing or editing any page, check `_glossary-internal.yaml` at the repo root. Use ONLY canonical names. Common mistakes to avoid:

| Always write | Never write |
|---|---|
| Workflow | flow, automation, scenario, journey |
| Datasource | data source, data-source, feed, connector |
| Content | creative, asset, visual, template |
| Node | step, block, element, box, action |
| Channel | touchpoint, medium, entry point |
| Branch | path, route, variant, scenario |
| Output Node | end node, terminal, result node |
| Data Node | data step, data block |
| Logic Node | decision step, logic block, routing node |
| DataHub | data hub, data center, data layer |
| Runner | engine, executor, processor, server |
| Uplift | lift, improvement, gain, boost |
| Incremental Value | added value, extra value |
| Exposed Population | test group, treatment group |
| Non-Exposed Population | control group, B group, holdout |
| Key Challenge | problematic, issue, pain point |
| Use Case | scenario, recipe, playbook |
| Content Editor | designer, builder, canvas |
| Real-Time Testing | A/B test node, split test, experiment |
| Transform | transformer, mutation, processor |
| Team | Resource Group (except in developer-docs where you add "(Resource Group)" in parentheses) |

## Language

- UK English spelling: personalisation, behaviour, colour, organisation
- Every `.mdx` file must have `title` and `description` in YAML frontmatter
- Use relative Mintlify paths for links (e.g. `/product-guide/workflows/overview`)
- Cross-directory links are encouraged
- Images go in `/images/{section}/` with descriptive alt text

## Directory Rules (read the full AGENTS.md in each directory)

### `product-guide/` — Low-maturity marketers
- Owner: Customer Success
- Tone: Friendly, encouraging, "you" voice
- Max sentence: 25 words. Max paragraph: 3 sentences.
- Explain concepts on first use with parenthetical: "Add a Data Node (a step that fetches external data)"
- **FORBIDDEN words**: API, SDK, endpoint, payload, JSON, schema, query (SQL sense), runtime, server-side, client-side, middleware, webhook
- **NEVER include**: code, API endpoints, architecture details, CLI commands

### `advanced-guide/` — Data-savvy marketers and TAMs
- Owner: Technical Account Managers
- Tone: Professional, precise, data-oriented
- Max sentence: 35 words. No need to explain platform terms.
- **CAN use**: query, schema, field, filter, aggregation, boolean, operator, p-value
- **FORBIDDEN**: SDK, npm, curl, HTTP method, REST, GraphQL, webhook, CI/CD, Docker
- **NEVER include**: code in any language, API request/response, SDK instructions

### `developer-docs/` — Software engineers
- Owner: Engineering
- Tone: Direct, concise, technical. Code-first.
- Max sentence: 40 words. No marketing language.
- Backend is "Runner" (never "engine" or "server"). Use exact npm names (`@rlvt/web-sdk`).
- Code: TypeScript, copy-pasteable, all imports, realistic variable names, error handling
- **NEVER include**: UI screenshots, UI step-by-step, marketing language, ROI claims

### `why-reelevant/` — Business + tech prospects
- Owner: Sales
- Tone: Professional, confident, benefit-oriented. Not salesy.
- Business pages: explain terms on first use, lead with problem → outcome → CTA
- Tech pages: architecture/data flow → protocols → integration effort → link to developer-docs
- **NEVER include**: UI instructions, code >5 lines, pricing, internal infra (Pinot, Pulsar, MongoDB)

### `product-adoption/` — Customers measuring ROI + prospects evaluating
- Owner: CS + TAM
- Tone: Authoritative, data-driven, pedagogical. Must withstand finance/leadership scrutiny.
- Max sentence: 35 words. Explain statistical terms on first use.
- Incremental Value pages: formula + worked example + Exposed vs Non-Exposed table
- Use Case Explorer: show connections (Key Challenge → Use Case → Datasource → Capability)
- **NEVER include**: code, UI instructions, pricing, customer-specific data

## PR Workflow

1. Create a new branch from `main` — name it `docs/{your-name}/{short-description}`
2. Make your edits following the directory-specific rules above
3. Validate JSON: `python3 -c "import json; json.load(open('docs.json'))"`
4. Commit with a descriptive message: `docs(product-guide): add workflow creation guide`
5. Push and open a PR against `main`
