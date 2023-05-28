#!/bin/bash

# Capture the list of directories
directories=$(find . -type d -not -path '*/\.*' -not -path '.' -not -path './.git*' -mindepth 2 -maxdepth 2)

# Output the directories as JSON
directories_JSOn=toJSON($directories)
echo "directories=$directories_JSOn" | tee $GITHUB_OUTPUT