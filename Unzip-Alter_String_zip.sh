#! /bin/bash

# Define the source and destination folders
source_folder="source_folder"
destination_folder="destination_folder"
temp_folder="temp_folder"

# Unzip the folder
unzip "$source_folder" -d "$temp_folder"

# Search for files with .L extension
find "$temp_folder" -type f -name "*.L" | while read file; do
    # Replace the string in each file
    sed -i 's/old_string/new_string/g' "$file"
done

# Re-zip the files back into a folder
zip -r "$destination_folder" "$temp_folder"/*

# Clean up the temporary folder
rm -rf "$temp_folder"

