# list_reviews_endpoint="/repos/$REPO_NAME/pulls/$PULL_NUMBER/reviews"
# echo $list_reviews_endpoint
# reviews=$(gh api \
#   -H "Accept: application/vnd.github+json" \
#   -H "X-GitHub-Api-Version: 2022-11-28" \
#   "$list_reviews_endpoint")
# echo "$reviews"
