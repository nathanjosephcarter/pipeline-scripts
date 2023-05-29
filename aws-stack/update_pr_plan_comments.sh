#!/bin/bash

# Source the sanitise directory name file
source "./pipeline-scripts/aws-stack/sanitise_directory_name.sh"

# Source the delete pr comment file
source "./pipeline-scripts/github/delete_pr_comment.sh"

# Set IFS to a space character
IFS=' '

# Split the space-separated string into an array
directories=($DIRECTORIES)

for dir in "${directories[@]}"; do
  # Get the new plan output
  file_name=$(sanitise_directory_name -d "$dir")
  output_path="./plan-outputs/$file_name.tfplan"
  new_plan_output=$(< "$output_path" tr -d '\000')

  # Get the previous comment ID for the directory (if exists)
  comment_ids=$(gh pr view $EVENT_NUMBER --json "comments,body,id" -q ".comments[] | select(.body | startswith(\"Terraform Plan Output - $dir\")) | .id")

  # Check if any comment IDs were found
  if [[ -n "$comment_ids" ]]; then
    # Sort the comment IDs in reverse order to keep the most recent one
    sorted_comment_ids=$(echo "$comment_ids" | sort -r)

    # Get the most recent comment ID
    most_recent_comment_id=$(echo "$sorted_comment_ids" | head -n 1)

    # Iterate over the sorted comment IDs
    for id in ${sorted_comment_ids[@]}; do
      echo $id
      # Skip the most recent comment ID
      if [[ $id != $most_recent_comment_id ]]; then
        # Delete the previous comment
        delete_pr_comment -r "aws-stack" -c "$id"
        echo "Deleted previous plan output comment with ID $id for $dir"
      fi
    done

    # Check if the new plan is different from the previous one
    if [[ -n "$most_recent_comment_id" ]]; then
      previous_plan_output=$(gh pr view $EVENT_NUMBER --json "comments,body" -q ".comments[] | select(.id == \"$most_recent_comment_id\") | .body" | sed 's/^Terraform Plan Output - $dir\n//')
      if [[ "$new_plan_output" != "$previous_plan_output" ]]; then
        # Delete the previous comment
        delete_pr_comment -r "aws-stack" -c "$most_recent_comment_id"
        echo "Deleted previous plan output comment for $dir"
        # Add a new comment with the new plan output
        gh pr comment $EVENT_NUMBER --body "$(echo -e "Terraform Plan Output - $dir\n$new_plan_output")"
        echo "Added new plan output comment for $dir"
      else
        echo "No changes in Terraform plan output for $dir. Skipping comment delete."
      fi
    fi
  else
    # Add a new comment with the new plan output
    gh pr comment $EVENT_NUMBER --body "$(echo -e "Terraform Plan Output - $dir\n$new_plan_output")"
    echo "Added new plan output comment for $dir"
  fi
done
