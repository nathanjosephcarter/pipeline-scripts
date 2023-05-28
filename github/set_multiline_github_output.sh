#!/bin/bash

# Function to set multiline output for GitHub Actions
set_multiline_github_output() {
  while getopts ":name:value:" flag; do
    case "$flag" in
      name) output_name_variable=$OPTARG ;;
      value) output_value_variable=$OPTARG ;;
      :) echo "Error: Option -$OPTARG requires an argument." >&2 ; exit 1 ;;
      \?) echo "Error: Invalid option -$OPTARG." >&2 ; exit 1 ;;
    esac
  done

  echo "${output_name_variable}<<EOF" >> "$GITHUB_OUTPUT"
  echo "${output_value_variable}" >> "$GITHUB_OUTPUT"
  echo 'EOF' >> "$GITHUB_OUTPUT"
}
