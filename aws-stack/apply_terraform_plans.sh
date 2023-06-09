# #!/bin/bash

# # Source the sanitise directory name file
# source "./pipeline-scripts/aws-stack/sanitise_directory_name.sh"

# read -r -a directories <<< "$DIRECTORIES"

# # Store the current working directory
# original_dir=$PWD

# for dir in "${directories[@]}"; do
#   cd "$dir" # Change to the directory
#   file_name=$(sanitise_directory_name -d "$dir")
#   output_path="../../plan-outputs/$file_name.tfplan"
#   echo "Applying $output_path"
#   terraform apply "$output_path"

#   # Change back to the previous directory
#   cd "$original_dir"
# done
