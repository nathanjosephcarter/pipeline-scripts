#!/bin/bash

# Source the output functions file
source "../github/set_multiline_github_output.sh"

# Capture the list of directories
directories=$(find . -type d -not -path '*/\.*' -not -path '.' -not -path './.git*' -not -path './pipeline-scripts*' -mindepth 2 -maxdepth 2)

echo $directories

set_multiline_github_output -name "directories" -value $directories
