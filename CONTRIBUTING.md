# Contributing to Reelevant Documentation with Claude Code

This guide helps each team member set up Claude Code to edit documentation and open PRs — no Git expertise required.

---

## Prerequisites (all roles)

1. **GitHub account** — you do NOT need write access to the main repo.
2. **Fork the repository** — go to [github.com/reelevant-tech/product-documentation](https://github.com/reelevant-tech/product-documentation) and click the **Fork** button (top right). This creates your own copy under your GitHub account.
3. **Claude Code** — use one of the two options:
   - **Cloud** (recommended, zero install): Go to [claude.ai/code](https://claude.ai/code), connect your GitHub account, and select **your fork** (e.g. `your-username/product-documentation`).
   - **Desktop app**: Download [Claude for Desktop](https://claude.ai/download), open it, and connect to **your fork** via the GitHub integration.
4. **Connect your fork**: When Claude Code asks which repository to work on, select your fork — not `reelevant-tech/product-documentation`. Claude Code will clone your fork and set up the workspace for you — no terminal commands needed.

That's it for setup. Now follow the section for your role below.

### Prefer working locally?

If you'd rather run Claude Code in your own terminal instead of the cloud or desktop app, follow [SETUP.md](./SETUP.md) for a step-by-step local install with Homebrew, gh, Node, and Claude Code.

It also auto-starts a live preview of the docs. Everything else in this guide — prompts, rules, and PR flow — still applies.

---

## Customer Success (CS)

**You own:** `product-guide/` — documentation for marketers with low technical maturity.

### Quick start

Open Claude Code (cloud or desktop) with your fork connected, then tell Claude what you need in plain language. Examples:

```
Add a new page explaining how to duplicate a Workflow in product-guide/workflows/.
The page should explain step by step how to use the duplicate button.
Follow the AGENTS.md rules for product-guide.
Then create a branch and open a PR to reelevant-tech/product-documentation.
```

```
Update the page product-guide/contents/components.mdx to add a section
about the new "countdown timer" component. Keep the tone friendly and
simple, following product-guide/AGENTS.md rules.
Open a PR to reelevant-tech/product-documentation when done.
```

### Rules to remind Claude about

- Friendly "you" voice, max 25-word sentences
- Never use technical words like API, SDK, endpoint, JSON
- Explain platform terms on first use: "Add a Data Node (a step that fetches external data)"
- Include screenshots references where possible
- End pages with "What's Next?" linking to related pages

---

## Technical Account Managers (TAM)

**You own:** `advanced-guide/` — documentation for data-savvy users with high maturity.

### Quick start

Open Claude Code with your fork connected. Example prompts:

```
Create a new page in advanced-guide/datahub/ explaining how to set up
a Snowflake Datasource with incremental sync. Include a worked example
with a product catalogue. Follow advanced-guide/AGENTS.md rules.
Open a PR to reelevant-tech/product-documentation when done.
```

```
Update advanced-guide/workflows/logic-nodes/conditions.mdx to document
the new "in list" operator for array fields. Add a table showing the
operator, expected input, and behaviour.
Open a PR to reelevant-tech/product-documentation.
```

### Rules to remind Claude about

- Professional and precise tone, max 35-word sentences
- Can use data terms (query, schema, field, boolean) but never code or SDK references
- Include worked examples with realistic data
- Use tables for configuration options
- Add `<Info>` blocks for edge cases

---

## Engineering

**You own:** `developer-docs/` — documentation for software engineers integrating with Reelevant.

### Quick start

Open Claude Code with your fork connected. Example prompts:

```
Add a new guide in developer-docs/ for server-side rendering with the
@rlvt/web-sdk. Show a TypeScript example with Next.js App Router.
Follow developer-docs/AGENTS.md.
Open a PR to reelevant-tech/product-documentation.
```

```
Update developer-docs/api-reference/authentication.mdx to add documentation
for the new API key rotation endpoint. Include request/response examples
and error codes. Follow developer-docs/AGENTS.md.
Open a PR to reelevant-tech/product-documentation.
```

### Rules to remind Claude about

- Code-first: show the code, then explain
- TypeScript examples that are copy-pasteable with all imports
- Call the backend "Runner" (never "engine" or "server")
- Document every parameter in tables (name, type, required, default, description)
- No marketing language, no UI screenshots

---

## Sales & Marketing

**You own:** `why-reelevant/` — content for business prospects and tech evaluators.

### Quick start

Open Claude Code with your fork connected. Example prompts:

```
Update why-reelevant/technical-evaluators/integrations.mdx to add a section
about our mobile SDK integration patterns. Focus on architecture and effort,
not UI steps. Follow why-reelevant/AGENTS.md.
Open a PR to reelevant-tech/product-documentation.
```

```
Create a new page in why-reelevant/technical-evaluators/ about authentication
options for enterprise deployments. Focus on protocols, token lifecycle, and
integration effort. Follow why-reelevant/AGENTS.md.
Open a PR to reelevant-tech/product-documentation.
```

### Rules to remind Claude about

- Professional and confident, not salesy — let capabilities speak
- Use concrete numbers ("6.7x ROI") instead of vague claims ("great results")
- Business pages: lead with the problem → show outcome → customer examples → CTA
- Tech evaluator pages: architecture → protocols → integration effort
- Never mention pricing or internal infrastructure (Pinot, Pulsar)

---

## General Tips for All Roles

### Always mention the rules

Claude Code reads `CLAUDE.md` and `AGENTS.md` automatically, but explicitly reminding it helps:

```
Follow the AGENTS.md rules for [your-directory]. Check _glossary-internal.yaml
for correct terminology.
```

### Always tell Claude to open a PR to the main repo

Since you are working from a fork, always specify the target:

```
Open a PR from my fork to reelevant-tech/product-documentation main branch.
```

### Ask Claude to validate before committing

```
Before opening the PR, validate that docs.json is valid JSON and that
all internal links point to existing pages.
```

### After you open a PR

Your PR will be **reviewed by a maintainer** before being merged. This is normal — expect feedback. You may be asked to make changes (tone adjustments, terminology fixes, restructuring). When you receive review comments:

1. Open Claude Code with your fork connected
2. Tell Claude what changes are needed:
   ```
   The reviewers on my PR asked me to [describe the feedback].
   Please make the changes and push to the same branch.
   ```
3. Claude will update the branch and the PR will automatically reflect the new changes
4. The reviewer will re-review and merge once everything looks good

### One topic per PR

Keep PRs focused on a single change (one new page, one section update). This makes review faster and reduces merge conflicts.

### Keep your fork up to date

Before starting new work, ask Claude to sync your fork:

```
Sync my fork with the latest changes from reelevant-tech/product-documentation main branch.
```
