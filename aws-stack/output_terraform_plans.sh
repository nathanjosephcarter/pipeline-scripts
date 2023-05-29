#!/bin/bash

# Source the sanitise directory name file
source "./pipeline-scripts/aws-stack/sanitise_directory_name.sh"

# Create the plan_outputs directory (if it doesn't exist)
mkdir -p plan-outputs

read -r -a directories <<< "$DIRECTORIES"

# Store the current working directory
original_dir=$PWD

# Iterate over each directory in the DIRECTORIES variable
for dir in "${directories[@]}"; do
  cd "$dir" # Change to the directory

  # Create the parent directories for the plan output file
  mkdir -p "../plan-outputs/$(dirname "$dir")"

  # Initialize Terraform in the current directory
  echo "Planning $dir"
  terraform init

  file_name=$(sanitise_directory_name -d "$dir")
  output_path="../plan-outputs/$file_name.tfplan"
  echo "Writing plan file $output_path"
  terraform plan -out "$output_path"

  # Change back to the previous directory
  cd "$original_dir"
done
