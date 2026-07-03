# Claude Code — Project Instructions

## What This Repo Is

Reelevant product documentation built with [Mintlify](https://mintlify.com). Four directories target different audience personas. Each directory has its own `AGENTS.md` with strict writing rules — **read the AGENTS.md in the directory you are editing before making any changes**.

## Before You Start Writing

**Always ask the contributor which persona they are targeting.** Before making any edit, confirm:

1. **Which directory** the change belongs to (`product-guide/`, `advanced-guide/`, `developer-docs/`, `why-reelevant/`)
2. **Who is the target reader** — match the contributor's intent to the right persona:

| If the contributor says... | Target directory |
|---|---|
| "for users", "for marketers", "how to use the UI" | `product-guide/` |
| "for advanced users", "for data teams", "for TAMs" | `advanced-guide/` |
| "for developers", "for engineers", "API docs", "SDK" | `developer-docs/` |
| "for prospects", "for sales", "why buy", "comparison" | `why-reelevant/` |
| "ROI", "incremental value", "use cases", "methodology" | `why-reelevant/` or `product-guide/analytics/` |

If the contributor's request is ambiguous or could fit multiple directories, **ask them to clarify the target persona before writing**. Never guess — writing in the wrong tone or vocabulary for a persona creates review churn.

Once you know the target directory, read its `AGENTS.md` and follow every rule strictly (tone, sentence length, forbidden words, structure).

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

## PR Workflow

Contributors work from **their own fork** — they do NOT have write access to the main repo.

1. The contributor is working on a fork of `reelevant-tech/product-documentation`. Make sure you are pushing to their fork, not to the upstream repo.
2. Create a new branch from `main` — name it `docs/{contributor-name}/{short-description}`
3. Make your edits following the directory-specific rules above
4. Validate JSON: `python3 -c "import json; json.load(open('docs.json'))"`
5. Commit with a descriptive message: `docs(product-guide): add workflow creation guide`
6. Push the branch to the fork
7. Open a PR **from the fork's branch** to `reelevant-tech/product-documentation` `main` branch
8. Tell the contributor that their PR will be **reviewed by a maintainer** and they may receive feedback requesting changes. This is a normal part of the process — not a rejection.

## Handling Review Feedback

When a contributor comes back saying their PR received review comments:

1. Read the review comments on the PR
2. Make the requested changes, following the same directory rules
3. Commit and push to the **same branch** on the fork — the PR updates automatically
4. Let the contributor know the changes are pushed and the reviewer will re-review
