#!/bin/bash

# Function to set multiline output for GitHub Actions
set_multiline_github_output() {
  local output_name_variable
  local output_value_variable

  while getopts ":n:v:" flag; do
    case "$flag" in
      n) output_name_variable=$OPTARG ;;
      v) output_value_variable=$OPTARG ;;
      :) echo "Error: Option -$OPTARG requires an argument." >&2 ; exit 1 ;;
      \?) echo "Error: Invalid option -$OPTARG." >&2 ; exit 1 ;;
    esac
  done

  if [[ -z $output_name_variable ]]; then
    echo "Error: Name must not be empty." >&2
    exit 1
  fi

  if [[ -z $output_value_variable ]]; then
    echo "Error: Value must not be empty." >&2
    exit 1
  fi

  echo "$output_name_variable<<EOF" >> "$GITHUB_OUTPUT"
  echo "$output_value_variable" >> "$GITHUB_OUTPUT"
  echo 'EOF' >> "$GITHUB_OUTPUT"
}
