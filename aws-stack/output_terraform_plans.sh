#!/bin/bash

# Create the plan_outputs directory (if it doesn't exist)
mkdir -p plan_outputs

# Read the multiline value of DIRECTORIES into an array
IFS=$'\n' read -r -d '' -a modified_directories <<< "$MODIFIED_DIRECTORIES"

# Iterate over each directory in the DIRECTORIES variable
for dir in "${modified_directories[@]}"; do
  cd "$dir" # Change to the directory

  # Create the parent directories for the plan output file
  mkdir -p "../plan_outputs/$(dirname "$dir")"

  # Initialize Terraform in the current directory
  terraform init

  # Perform Terraform plan and save the output to the plan_outputs directory
  sanitized_dir="${dir#./}" # Remove leading ./ from directory name
  sanitized_dir="${sanitized_dir//\//-}" # Replace slashes with dashes in directory name
  output_path="../plan_outputs/$sanitized_dir.tfplan"
  echo "Writing plan file $output_path"
  terraform plan -out "$output_path"

  cd .. # Change back to the previous directory
done
