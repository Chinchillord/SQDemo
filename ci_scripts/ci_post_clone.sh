#!/bin/sh
set -e

echo "==> Current dir is: $(pwd)"
cd "$(pwd)"  # Redundant, but safe

# Restore refs for SonarQube
git checkout -b temp || echo "==> Branch temp already exists, continuing"
git branch -D "$CI_PULL_REQUEST_TARGET_BRANCH" || echo "==> Target branch doesn't exist locally, skipping delete"

git config remote.origin.fetch "+refs/heads/$CI_PULL_REQUEST_SOURCE_BRANCH:refs/remotes/origin/$CI_PULL_REQUEST_SOURCE_BRANCH"
git config --add remote.origin.fetch "+refs/heads/$CI_PULL_REQUEST_TARGET_BRANCH:refs/remotes/origin/$CI_PULL_REQUEST_TARGET_BRANCH"
git fetch origin
