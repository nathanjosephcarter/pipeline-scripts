directories=$(find . -type d -not -path '*/\.*' -not -path '.' -not -path './.git*'  -not -path './pipeline-scripts*' -mindepth 2 -maxdepth 2)
echo "directories=$directories" | tee $GITHUB_OUTPUT