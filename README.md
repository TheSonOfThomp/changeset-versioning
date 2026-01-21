# changeset-versioning

A monorepo setup demonstrating changesets versioning with automated releases and validation.

## Features

- ✅ Automated versioning and publishing with changesets
- ✅ Separate workflows for patch/minor releases (main) and major releases (next)
- ✅ Changeset validation to enforce versioning rules
- ✅ Changesets Bot integration (see setup guide below)

## Changesets Bot

The Changesets Bot is a GitHub App that automatically comments on PRs missing changeset files.

**Setup:** See [`.github/CHANGESETS_BOT_SETUP.md`](.github/CHANGESETS_BOT_SETUP.md) for installation instructions.

## Workflow Overview

- **PRs to `main`**: Create patch/minor release PRs
- **PRs to `next`**: Create pre-release and major release PRs
- **Validation**: Ensures major changesets only go to `next` branch
- **Bot**: Provides friendly reminders when changesets are missing

## Quick Start

1. Install the Changesets Bot (see setup guide)
2. Make code changes
3. Run `pnpm changeset` to create a changeset file
4. Open a PR - the bot and CI will validate everything