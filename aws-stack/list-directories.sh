#!/bin/bash

ls ./pipeline-scripts/github
echo ""
ls -l ./pipeline-scripts/github/set_multiline_github_output.sh

# Source the output functions file
source "./pipeline-scripts/github/set_multiline_github_output.sh"

# Capture the list of directories
directories=$(find . -type d -not -path '*/\.*' -not -path '.' -not -path './.git*' -not -path './pipeline-scripts*' -mindepth 2 -maxdepth 2)

# Print the directories
echo $directories

# Call the function to set the multiline output
set_multiline_github_output -name "directories" -value $directories
