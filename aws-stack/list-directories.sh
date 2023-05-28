#!/bin/bash

# Capture the list of directories
directories=$(find . -type d -not -path '*/\.*' -not -path '.' -not -path './.git*' -mindepth 2 -maxdepth 2)

# Output the directories as JSON
directories_JSON=toJSON($directories)
echo "directories=$directories_JSON" | tee $GITHUB_OUTPUT