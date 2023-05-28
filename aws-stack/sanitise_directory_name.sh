#!/bin/bash

# Function to santise directory name
sanitise_directory_name() {
  local output_directory_variable

  while getopts ":d:" flag; do
    case "$flag" in
      d) output_directory_variable=$OPTARG ;;
      :) echo "Error: Option -$OPTARG requires an argument." >&2 ; exit 1 ;;
      \?) echo "Error: Invalid option -$OPTARG." >&2 ; exit 1 ;;
    esac
  done

  if [[ -z $output_directory_variable ]]; then
    echo "Error: Directory must not be empty." >&2
    exit 1
  fi

  sanitised_dir="${output_directory_variable#./}" # Remove leading ./ from directory name
  sanitised_dir="${sanitised_dir//\//-}" # Replace slashes with dashes in directory name

  echo "$sanitised_dir" # Output the sanitized directory string
}
