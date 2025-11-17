#!/bin/bash

cd ~/github/whalelogic/ || exit

# Loop over all Markdown files in content/posts/
find content/posts -type f -name "*.md" | while read -r file; do
    # Check if the front matter contains a date
    if ! grep -q '^date *= *"' "$file"; then
        # Get the file modification time in ISO 8601 format
        mod_time=$(date -r "$file" +"%Y-%m-%dT%H:%M:%S%:z")
        echo "Adding date to $file: $mod_time"

        # Insert date after the first line (after +++)
        # Works for TOML front matter
        sed -i "1a date = \"$mod_time\"" "$file"
    fi
done
