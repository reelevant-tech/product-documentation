# Local setup with Claude Code

This guide is for non-technical Reelevant teammates on macOS who want to edit docs locally. You will run Claude Code in your terminal, tell it what to change in plain English, and see a live Mintlify preview at <http://localhost:3000> as you work.

## What you'll end up with

Claude Code running in your terminal, making doc changes from plain-English instructions. A live Mintlify preview will open at <http://localhost:3000>, and it will start automatically when Claude Code launches in this repo.

## Step 1 — Install Homebrew

Homebrew is the package manager we use to install the tools below.

Run this in Terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the on-screen instructions. It may ask for your Mac password and then show a couple of PATH commands to copy and paste at the end.

If you're on Linux or WSL, Homebrew can still work, but the install steps are slightly different. See [brew.sh](https://brew.sh) for the right instructions.

## Step 2 — Install the tools

Install GitHub CLI and Node.js with Homebrew:

```bash
brew install gh node
```

- `gh` lets you sign in to GitHub, fork the repo, clone it, and open PRs.
- `node` gives you `npm`, which installs the Mintlify preview tool.

Install Claude Code:

```bash
brew install --cask claude-code
```

- `claude-code` is the app you will talk to in your terminal.

If you prefer the native installer, this is the alternative:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Install the Mintlify CLI:

```bash
npm i -g mint
```

- `mint` runs the local docs preview.

## Step 3 — Sign in to GitHub

Run:

```bash
gh auth login
```

Choose:

1. GitHub.com
2. HTTPS
3. Login with a web browser

Follow the prompts. This lets you clone the repo and open PRs without dealing with tokens.

## Step 4 — Get the code

If you do not have write access to the main repo, fork and clone it in one step:

```bash
gh repo fork reelevant-tech/product-documentation --clone
```

If you do have write access, you can clone the main repo directly:

```bash
gh repo clone reelevant-tech/product-documentation
```

Then go into the folder:

```bash
cd product-documentation
```

## Step 5 — Start Claude Code

Run this inside the repo folder:

```bash
claude
```

The first time, it will help you sign in to your Anthropic account. Thanks to the launch config in this repo (`.claude/settings.json`), Claude Code automatically starts the docs preview as soon as it opens.

Open <http://localhost:3000> in your browser to see your changes live while you edit. If the preview does not start, it is usually because `mint` is not installed yet — repeat the `npm i -g mint` step.

## Step 6 — Ask Claude to make a change

Try a prompt like this:

```text
Please add a new page about setting up local docs editing with Claude Code.
Then open a PR to reelevant-tech/product-documentation.
Follow the notes in CONTRIBUTING.md for the right prompts and rules.
```

For more examples and team-specific guidance, see [CONTRIBUTING.md](./CONTRIBUTING.md).

## Troubleshooting

- `command not found: brew` — open a new terminal, or run the PATH commands Homebrew printed at the end of the install.
- `command not found: mint` — run `npm i -g mint`.
- Preview not loading — make sure you ran `claude` from inside the repo folder, then check `/tmp/mintlify-preview.log`.
- Port 3000 busy — the preview may already be running in another tab.
