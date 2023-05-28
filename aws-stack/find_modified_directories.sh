#!/bin/bash

readarray -t directories <<< "$DIRECTORIES"

git fetch origin $TARGET_BRANCH

modified_directories=()
for dir in "${DIRECTORIES[@]}"; do
  git_diff_output=$(git diff "origin/$TARGET_BRANCH" --name-only -- $dir)
  if [[ -n "$git_diff_output" ]]; then
    echo "File changes detected in $dir."
    modified_directories+=("$dir")
  else
    echo "No file changes detected in $dir."
  fi
done
