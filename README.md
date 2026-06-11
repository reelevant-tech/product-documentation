# Reelevant API Documentation

Mintlify documentation site for the Reelevant API, including authentication, transformations, and OpenAPI references.

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
