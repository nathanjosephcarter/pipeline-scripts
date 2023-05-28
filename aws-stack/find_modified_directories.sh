#!/bin/bash

echo "Directories:"
echo $directories
echo "Target Branch:"
echo $target_branch

# readarray -t directories <<< "$directories"

# git fetch origin $target_branch

# modified_directories=()
# for dir in "${directories[@]}"; do
#   echo $dir
#   git_diff_output=$(git diff $target_branch --name-only -- $dir)
#   if [[ -n "$git_diff_output" ]]; then
#     echo "File changes detected in $dir."
#     modified_directories+=("$dir")
#   else
#     echo "No file changes detected in $dir."
#   fi
# done
