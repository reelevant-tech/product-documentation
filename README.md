# Reelevant API Documentation

Mintlify documentation site for the Reelevant API, including authentication, transformations, and OpenAPI references.

## Editing with Claude Code (recommended for most contributors)

Most contributors — including non-technical teammates — edit these docs with the Claude Code desktop app in plain English. Start with [SETUP.md](./SETUP.md) for the one-time local setup, and use [CONTRIBUTING.md](./CONTRIBUTING.md) for team-specific prompts and rules.

This repo also ships a launch config (`.claude/settings.json`) that starts the Mintlify preview automatically when Claude Code opens, so you can see changes live as you work.

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
