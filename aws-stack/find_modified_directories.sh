#!/bin/bash

# Source the output functions file
source "./pipeline-scripts/github/set_multiline_github_output.sh"

# Read the multiline value of DIRECTORIES into an array
IFS=$'\n' read -r -d '' -a directories <<< "$DIRECTORIES"

# Fetch the target branch
git fetch origin "$TARGET_BRANCH"

# Initialize an array to store modified directories
modified_directories=()

# Iterate over each directory
for dir in "${directories[@]}"; do
  # Check for file changes in the directory
  git_diff_output=$(git diff "origin/$TARGET_BRANCH" --name-only -- "$dir")
  if [[ -n "$git_diff_output" ]]; then
    echo "File changes detected in $dir."
    modified_directories+=("$dir")
  else
    echo "No file changes detected in $dir."
  fi
done

# Set the modified directories as a multiline output
set_multiline_github_output -n "modified_directories" -v "$modified_directories"
