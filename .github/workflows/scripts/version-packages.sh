#!/bin/bash
# Version packages using changesets
#
# This script runs `changeset version` to update package versions based on
# changesets, then checks if any files were modified. It sets `version_updated=true`
# in GitHub Actions outputs if packages were versioned, otherwise `version_updated=false`.
#
# This is used by the release-major workflow to determine if a release PR should be created.

set -uo pipefail

if [ -z "${GITHUB_OUTPUT:-}" ]; then
  echo "Error: GITHUB_OUTPUT is not set" >&2
  exit 1
fi

# Run version command (will exit 0 even if no changesets)
pnpm changeset version

# Check if version updated any files
if git diff --quiet && git diff --cached --quiet; then
  echo "version_updated=false" >> "${GITHUB_OUTPUT}"
  echo "No packages were versioned"
else
  echo "version_updated=true" >> "${GITHUB_OUTPUT}"
  echo "Packages were versioned"
fi
