#!/bin/bash

# Source the output functions file
source "./pipeline-scripts/github/set_multiline_github_output.sh"

IFS=$'\n' read -r -d '' -a directories <<< "$DIRECTORIES"

git fetch origin "$TARGET_BRANCH"

modified_directories=()
for dir in "${directories[@]}"; do
  git_diff_output=$(git diff "origin/$TARGET_BRANCH" --name-only -- "$dir")
  if [[ -n "$git_diff_output" ]]; then
    echo "File changes detected in $dir."
    modified_directories+=("$dir")
  else
    echo "No file changes detected in $dir."
  fi
done

set_multiline_github_output -n "modified_directories" -v "$modified_directories"
