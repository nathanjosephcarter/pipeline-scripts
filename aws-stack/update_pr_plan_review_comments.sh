gh --version
reviews=(gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "/repos/nathanjosephcarter/$REPO/pulls/$PULL_NUMBER/reviews")
echo $reviews