#!/bin/bash
# Check if the 'next' branch exists in the remote repository
#
# This script checks if the 'next' branch exists on the remote origin by
# querying git ls-remote. If the branch exists, it sets `exists=true` in
# GitHub Actions outputs, otherwise `exists=false`.
#
# This is used by the check-major-changes workflow to determine whether
# the 'next' branch needs to be created before redirecting PRs with major
# changes from 'main' to 'next'.

if git ls-remote --heads origin next | grep -q next; then
  echo "exists=true" >> $GITHUB_OUTPUT
  echo "next branch already exists"
else
  echo "exists=false" >> $GITHUB_OUTPUT
  echo "next branch does not exist"
fi
