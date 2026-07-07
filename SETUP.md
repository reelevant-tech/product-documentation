# Local setup with Claude Code

This guide is for non-technical Reelevant teammates who want to edit docs with the Claude Code desktop app. You will work in a GUI, tell Claude what to change in plain English, and see a live preview when Mintlify is available.

## What you'll end up with

The Claude Code desktop app open on your computer, ready to edit docs from plain-English prompts. If you turn on the live preview, the docs will appear at `http://localhost:3000` and show inside the app's embedded browser.

## Step 1 — Install the Claude Code desktop app

Download Claude Code from [claude.com/download](https://claude.com/download) and install it.

Open the app and sign in with your Anthropic account. It works on macOS, Windows, and Linux, and you do not need a terminal for the core flow.

## Step 2 — Connect your GitHub account

Inside the app, connect your GitHub account.

When you create your first PR, the app will prompt you to install `gh` if needed. Accept that prompt — it is what lets Claude work with GitHub, fork or clone the repo, and open PRs.

If you prefer to pre-install `gh` on macOS, you can use Homebrew (`brew install gh`), but it is not required.

## Step 3 — Open the repo

Use the app's GitHub picker to open `reelevant-tech/product-documentation`.

If you do not have write access, fork it first from inside the app and then open your fork. If you do have write access, you can open the main repo directly.

## Step 4 — Ask Claude to make a change

Ask Claude for the change you want in plain English. For example:

```text
Please add a short page explaining how to get started with Claude Code for local docs editing.
Then open a PR to reelevant-tech/product-documentation.
Follow the notes in CONTRIBUTING.md for the right prompts and rules.
```

For more examples and team-specific guidance, see [CONTRIBUTING.md](./CONTRIBUTING.md).

## Optional — turn on the live preview

If you want the Mintlify preview to start automatically, install Homebrew, Node, and the Mintlify CLI on macOS:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install node
npm i -g mint
```

The launch config in this repo (`.claude/settings.json`) will then start `mint dev` automatically when Claude Code opens, and you can view the preview at `http://localhost:3000` in the app's embedded browser.

This step is optional. You can still use the desktop app without it; you just will not get the automatic live preview.

## Troubleshooting

- Preview not loading — make sure Node and `mint` are installed (`npm i -g mint`) and that you opened the repo folder in the app.
- Preview not loading — check `/tmp/mintlify-preview.log` for the Mintlify output.
- Port 3000 busy — the preview may already be running in another tab.
