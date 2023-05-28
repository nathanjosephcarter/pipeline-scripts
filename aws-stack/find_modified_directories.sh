#!/bin/bash

git fetch origin $target_branch

changed_directories=()
while IFS= read -r dir; do
  echo $dir
  echo $target_branch
  target_branch_name="origin/$target_branch" 
  echo $target_branch_name
  git_diff_output=$(git diff $target_branch_name --name-only -- "./prod/spotify-automation-tasks")
  if [[ -n "$git_diff_output" ]]; then
    echo "File changes detected in $dir."
    changed_directories+=("$dir")
  else
    echo "No file changes detected in $dir."
  fi
done <<< "$directories"
