# Reelevant API Documentation

Mintlify documentation site for the Reelevant API, including authentication, transformations, and OpenAPI references.

## Editing with Claude Code (recommended for most contributors)

Most contributors — including non-technical teammates — edit these docs with the Claude Code desktop app in plain English. Start with [SETUP.md](./SETUP.md) for the one-time local setup, and use [CONTRIBUTING.md](./CONTRIBUTING.md) for team-specific prompts and rules.

This repo also ships a launch config (`.claude/settings.json`) that starts the Mintlify preview automatically when Claude Code opens, so you can see changes live as you work.

### First-time setup — let Claude configure your machine

Never used this before? Open Claude Code and paste the prompt below. Claude will set up everything for you — a GitHub account, the tools it needs, your own fork of the repo, and a live preview — one step at a time, in plain language.

```text
You are my setup assistant and I am not technical. Guide me end to end through
everything I need to start editing the Reelevant documentation, doing as much of
the work for me as you can. Explain each step in simple language, run the commands
yourself where possible, and pause to help me whenever something needs my input
(a password, a browser sign-in, etc.). Do these in order and confirm each one
worked before moving on:

1. GitHub account: check whether the GitHub CLI is already signed in. If not, help
   me either create a new GitHub account at https://github.com/signup or sign in to
   my existing one.
2. Homebrew: if the `brew` command is missing, install Homebrew from https://brew.sh
   and make sure it is on my PATH.
3. GitHub CLI: install it with `brew install gh`, then run `gh auth login` and walk
   me through signing in with my web browser.
4. Fork and clone: fork this repository to my account and clone the fork locally in
   one step with `gh repo fork reelevant-tech/product-documentation --clone`.
5. Enter the project: `cd product-documentation`.
6. Preview tools: install Node (version 22 or later is required) with
   `brew install node`, then the Mintlify CLI with `npm i -g mint`.
7. Launch the preview: start the docs preview server with `mint dev` and give me the
   link (http://localhost:3000) so I can see the docs in my browser.

When everything is running, tell me I'm ready and show me an example of how to ask
you to make a documentation change.
```

Prefer a click-by-click walkthrough instead? See [SETUP.md](./SETUP.md).

## Development

Install the [Mintlify CLI](https://www.npmjs.com/package/mint) to preview changes locally:

```bash
npm i -g mint
```

Run the dev server from the repository root (where `docs.json` is located):

```bash
mint dev
```

View the local preview at `http://localhost:3000`.

## Project structure

- `docs.json` - Site configuration, navigation, branding, and API settings
- `custom.css` - Reelevant brand styling overrides
- `api-reference/` - MDX documentation pages
- `logo/` - Light and dark mode logos
- `fonts/` - Switzer and Instrument Serif font files

## Branding

The site uses Reelevant brand colors and typography aligned with [reelevant.com](https://reelevant.com):

- Light mode links and accents use blue (`#5B5EFF`)
- Dark mode accents use yellow (`#EEFF00`)
- Default appearance is dark mode

## Publishing changes

Changes deploy automatically after pushing to the default branch when the Mintlify GitHub app is connected to this repository.

## Resources

- [Mintlify documentation](https://mintlify.com/docs)
- [Reelevant website](https://reelevant.com)
- [Reelevant dashboard](https://app.reelevant.com)
