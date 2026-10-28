#!/bin/bash
set -e

# mise
eval "$(mise activate bash)"
mise fmt
mise install

# Run shared lint tasks
mise run gha-lint
mise run shell-lint

# Check every generated cask without evaluating its install hooks.
for cask in Casks/*.rb; do
  echo "Checking $cask"
  ruby -c "$cask"
done

# Check for uncommitted changes
git diff --exit-code
