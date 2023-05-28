#!/bin/bash

# Capture the list of directories
directories=$(find . -type d -not -path '*/\.*' -not -path '.' -not -path './.git*' -mindepth 2 -maxdepth 2)
spaceSeparated=$(printf "%s " "${directories[@]}")

echo $spaceSeparated | tee $GITHUB_OUTPUT
