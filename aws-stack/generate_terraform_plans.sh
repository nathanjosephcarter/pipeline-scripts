#!/bin/bash

# Create the plan_outputs directory (if it doesn't exist)
mkdir -p plan_outputs

# Set the IFS variable to split on newline characters
IFS=$'\n'

# Iterate over each directory in the DIRECTORIES variable
for dir in $MODIFIED_DIRECTORIES; do
  cd "$dir" # Change to the directory

  # Create the parent directories for the plan output file
  mkdir -p "../plan_outputs/$(dirname "$dir")"

  # Initialize Terraform in the current directory
  terraform init

  # Perform Terraform plan and save the output to the plan_outputs directory
  output_path="../plan_outputs/${dir//\//-}.tfplan"
  echo "Writing plan file $output_path"
  terraform plan -out "$output_path"

  cd .. # Change back to the previous directory
done
