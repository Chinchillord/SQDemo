#!/bin/sh
set -e

# Ensure workspace exists
if [ -z "$CI_WORKSPACE" ] || [ ! -d "$CI_WORKSPACE" ]; then
  echo "❌ CI_WORKSPACE not set or does not exist: '$CI_WORKSPACE'"
  exit 1
fi

# Fetch refs for SonarQube analysis
echo "==> Restoring Git refs for SonarQube"

cd "$CI_WORKSPACE"
git checkout -b temp || echo "==> Branch temp already exists, continuing"
git branch -D "$CI_PULL_REQUEST_TARGET_BRANCH" || echo "==> Target branch doesn't exist locally, skipping delete"

git config remote.origin.fetch "+refs/heads/$CI_PULL_REQUEST_SOURCE_BRANCH:refs/remotes/origin/$CI_PULL_REQUEST_SOURCE_BRANCH"
git config --add remote.origin.fetch "+refs/heads/$CI_PULL_REQUEST_TARGET_BRANCH:refs/remotes/origin/$CI_PULL_REQUEST_TARGET_BRANCH"
git fetch origin
