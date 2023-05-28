directories=$(find . -type d -not -path '*/\.*' -not -path '.' -not -path './.git*' -mindepth 2 -maxdepth 2)
directories=$(find .)
echo "directories=$directories" | tee $GITHUB_OUTPUT