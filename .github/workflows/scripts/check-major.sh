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

# Run changeset status once and check for major changes
# Capture output to check for major changes
STATUS_OUTPUT=$(pnpm changeset status 2>&1 || true)

# DEBUG
echo $STATUS_OUTPUT; 

# Check if the output contains major changes
if echo "$STATUS_OUTPUT" | grep -q "Packages to be bumped at major"; then
  echo "has_major=true" >> "${GITHUB_OUTPUT}"
  echo "Major changes detected in changesets"
else
  echo "has_major=false" >> "${GITHUB_OUTPUT}"
  echo "No major changes detected"
fi
