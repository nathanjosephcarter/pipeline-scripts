#!/bin/bash

# Source the sanitise directory name file
source "./pipeline-scripts/aws-stack/sanitise_directory_name.sh"

# Set IFS to a space character
IFS=' '

# Split the space-separated string into an array
directories=($DIRECTORIES)

for dir in "${directories[@]}"; do
  # Get the new plan output
  file_name=$(sanitise_directory_name -d "$directory")
  output_path="./plan_outputs/$file_name.tfplan"
  new_plan_output=$(cat "$output_path")

  # Get the previous comment ID for the directory (if exists)
  comment_id=$(gh pr view $EVENT_NUMBER --json "comments,body,id" -q ".comments[] | select(.body | startswith(\"Terraform Plan Output - $dir\")) | .id")
  echo "Previous comment ID for $dir: $comment_id"

  # Check if the new plan is different from the previous one
  if [[ -n "$comment_id" ]]; then
    previous_plan_output=$(gh pr view $EVENT_NUMBER --json "comments,body" -q ".comments[] | select(.id == \"$comment_id\") | .body" | sed 's/^Terraform Plan Output - $dir\n//')
    if [[ "$new_plan_output" != "$previous_plan_output" ]]; then
      # Delete the previous comment
      gh pr comment --delete $comment_id
      echo "Deleted previous plan output comment for $dir"
    else
      echo "No changes in Terraform plan output for $dir. Skipping comment delete."
    fi
  fi

  # Add a new comment with the new plan output
  gh pr comment $EVENT_NUMBER --body "$(echo -e "Terraform Plan Output - $dir\n$new_plan_output")"
  echo "Added new plan output comment for $dir"
done
