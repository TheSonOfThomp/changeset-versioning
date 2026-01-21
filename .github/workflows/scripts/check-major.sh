#!/bin/bash
# Check for major changesets in the repository
#
# This script checks if any changesets contain major version bumps by parsing
# the output of `changeset status`. If major changes are detected, it sets
# `has_major=true` in GitHub Actions outputs, otherwise `has_major=false`.
#
# This is used by the check-major-changes workflow to automatically redirect
# PRs with major changes from the `main` branch to the `next` branch, keeping
# major releases separate from patch/minor releases.

set -uo pipefail

if [ -z "${GITHUB_OUTPUT:-}" ]; then
  echo "Error: GITHUB_OUTPUT is not set" >&2
  exit 1
fi

# Capture and clean output, stripping ANSI color codes that interfere with grep
STATUS_OUTPUT=$(NO_COLOR=1 pnpm changeset status 2>&1 || true)
CLEAN_OUTPUT=$(echo "$STATUS_OUTPUT" | sed 's/\x1b\[[0-9;]*m//g')

# Check for major changes
if echo "$CLEAN_OUTPUT" | grep -q "Packages to be bumped at major"; then
  echo "has_major=true" >> "${GITHUB_OUTPUT}"
  echo "Major changes detected in changesets: $CLEAN_OUTPUT"
else
  echo "has_major=false" >> "${GITHUB_OUTPUT}"
  echo "No major changes detected: $CLEAN_OUTPUT"
fi
