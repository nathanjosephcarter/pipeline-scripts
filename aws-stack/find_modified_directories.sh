#!/bin/bash

git fetch origin $target_branch

mapfile -t directories <<< "$directories"

changed_directories=()
for dir in $directories; do
  git_diff_output=$(git diff origin/$target_branch --name-only -- "$dir")
  if [[ -n "$git_diff_output" ]]; then
    echo "File changes detected in $dir."
    changed_directories+=("$dir")
  else
    echo "No file changes detected in $dir."
  fi
done
