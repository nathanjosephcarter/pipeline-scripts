#!/bin/bash

# Capture the list of directories
directories=$(find . -type d -not -path '*/\.*' -not -path '.' -not -path './.git*' -not -path './pipeline-scripts*' -mindepth 2 -maxdepth 2)

echo $directories

echo 'directories<<EOF' >> $GITHUB_OUTPUT
echo "$directories" >> $GITHUB_OUTPUT
echo 'EOF' >> $GITHUB_OUTPUT