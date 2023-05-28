directories=$(find . -type d -not -path '*/\.*' -not -path '.' -not -path './.git*' -mindepth 2 -maxdepth 2)
directories=$(find . -type d)
echo "directories=$directories" | tee $GITHUB_OUTPUT