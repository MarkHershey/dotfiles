#!/bin/bash

# Define the directory to clean (home directory)
directory="$HOME"

# List of file extensions and filenames to delete (you can customize this)
patterns=( "*.tmp" "*.bak" "*.swp" "*~" ".zcompdump*" ".*_history" ".viminfo" ".wget-hsts" ".sudo_as_admin_successful" )

# Array to store files to be cleaned
files_to_clean=()

# Find and add matching files to the array
for pattern in "${patterns[@]}"; do
    while IFS= read -r -d $'\0' file; do
        files_to_clean+=("$file")
    done < <(find "$directory" -maxdepth 1 -type f -name "$pattern" -print0)
done

# Check if there are files to clean
if [ ${#files_to_clean[@]} -eq 0 ]; then
    echo "No temporary files or command history files found for cleanup in $directory."
else
    # List files to be cleaned
    echo "The following files will be cleaned up in $directory:"
    for file in "${files_to_clean[@]}"; do
        echo "$file"
    done

    # Ask for user confirmation
    read -p "Do you want to proceed with the cleanup? (y/n): " choice

    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
        # Remove the files
        for file in "${files_to_clean[@]}"; do
            rm -f "$file"
        done
        echo "Cleanup complete."
    else
        echo "Cleanup aborted."
    fi
fi
