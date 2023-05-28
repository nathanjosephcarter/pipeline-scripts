#!/bin/bash

# Read the multiline value of DIRECTORIES into an array
IFS=$'\n' read -r -d '' -a directories <<< "$DIRECTORIES"

# Fetch the target branch
git fetch origin "$TARGET_BRANCH"

# Initialize arrays to store modified and unchanged directories
modified_directories=()
unchanged_directories=()

# Iterate over each directory
for dir in "${directories[@]}"; do
  # Check for file changes in the directory
  git_diff_output=$(git diff "origin/$TARGET_BRANCH" --name-only -- "$dir")
  if [[ -n "$git_diff_output" ]]; then
    modified_directories+=("$dir")
  else
    unchanged_directories+=("$dir")
  fi
done

# Print the modified directories
echo "Modified Directories:"
for dir in "${modified_directories[@]}"; do
  echo "$dir"
done

# Print the unchanged directories
echo "Unchanged Directories:"
for dir in "${unchanged_directories[@]}"; do
  echo "$dir"
done

array_string="${modified_directories[*]}"
echo "modified_directories=$array_string" >> "$GITHUB_OUTPUT"
