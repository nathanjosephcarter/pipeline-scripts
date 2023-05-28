#!/bin/bash

# Capture the list of directories
directories=$(find . -type d -not -path '*/\.*' -not -path '.' -not -path './.git*' -not -path './pipeline-scripts*' -mindepth 2 -maxdepth 2)

# Output a space-separated list
echo "directories=$(echo $directories | tr '\n' ' ')" | tee $GITHUB_OUTPUT
