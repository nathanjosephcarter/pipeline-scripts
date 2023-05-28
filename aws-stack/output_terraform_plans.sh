#!/bin/bash

# Create the plan_outputs directory (if it doesn't exist)
mkdir -p plan_outputs

read -r -a modified_directories <<< "$MODIFIED_DIRECTORIES"

# Store the current working directory
original_dir=$PWD

# Iterate over each directory in the DIRECTORIES variable
for dir in "${modified_directories[@]}"; do
  cd "$dir" # Change to the directory
  echo "Current working directory: $PWD"
  ls
  ls -al "$dir" # Debug output - list directory contents

  # Create the parent directories for the plan output file
  mkdir -p "../plan_outputs/$(dirname "$dir")"

  # Initialize Terraform in the current directory
  echo "Initialising plan for $dir"
  terraform init

  # Perform Terraform plan and save the output to the plan_outputs directory
  sanitized_dir="${dir#./}" # Remove leading ./ from directory name
  sanitized_dir="${sanitized_dir//\//-}" # Replace slashes with dashes in directory name
  output_path="../plan_outputs/$sanitized_dir.tfplan"
  echo "Writing plan file $output_path"
  terraform plan -out "$output_path"

  # Change back to the previous directory
  echo "Changing back to the previous directory: $original_dir"
  cd "$original_dir"
done
