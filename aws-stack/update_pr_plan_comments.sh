#!/bin/bash

# Read the multiline value of DIRECTORIES into an array
IFS=$'\n' read -r -d '' -a directories <<< "$DIRECTORIES"

for dir in "${directories[@]}"; do
  # Get the previous comment ID for the directory (if exists)
  comment_id=$(gh pr view $EVENT_NUMBER --json "comments,body,id" -q ".comments[] | select(.body | startswith(\"Terraform Plan Output - $dir\")) | .id")
  echo "Previous comment ID for $dir: $comment_id"

#   # Get the new plan output
#   new_plan_output=$(cat plan_output.txt)

#     # Check if the new plan is different from the previous one
#     if [[ -n "$comment_id" ]]; then
#     previous_plan_output=$(gh pr view ${{ github.event.number }} --json "comments,body" -q ".comments[] | select(.id == \"$comment_id\") | .body" | sed 's/^Terraform Plan Output - $dir\n//')
#     if [[ "$new_plan_output" != "$previous_plan_output" ]]; then
#         # Delete the previous comment
#         gh pr comment --delete $comment_id
#         echo "Deleted previous plan output comment for $dir"
#     else
#         echo "No changes in Terraform plan output for $dir. Skipping comment delete."
#     fi
#     fi

#     # Add a new comment with the new plan output
#     gh pr comment ${{ github.event.number }} --body "$(echo -e "Terraform Plan Output - $dir\n$new_plan_output")"
#     echo "Added new plan output comment for $dir"
done

