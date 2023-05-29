# When Github allows for PR comments to be deleted this could possible be used


# #!/bin/bash

# # Function to santise directory name
# delete_pr_comment() {
#   local output_repo_variable
#   local output_comment_variable

#   while getopts ":r:c:" flag; do
#     case "$flag" in
#       r) output_repo_variable=$OPTARG ;;
#       c) output_comment_variable=$OPTARG ;;
#       :) echo "Error: Option -$OPTARG requires an argument." >&2 ; exit 1 ;;
#       \?) echo "Error: Invalid option -$OPTARG." >&2 ; exit 1 ;;
#     esac
#   done

#   if [[ -z $output_repo_variable ]]; then
#     echo "Error: Repo must not be empty." >&2
#     exit 1
#   fi

#   if [[ -z $output_comment_variable ]]; then
#     echo "Error: Comment ID must not be empty." >&2
#     exit 1
#   fi

#   endpoint="/repos/nathanjosephcarter/$output_repo_variable/pulls/comments/$output_comment_variable"
#   echo "Endpoint:"
#   echo $endpoint

#   gh api \
#     --method DELETE \ # this is incorrect - deletes a PR Review comment rather than a PR comment
#     -H "Accept: application/vnd.github+json" \
#     -H "X-GitHub-Api-Version: 2022-11-28" \
#     $endpoint
# }

