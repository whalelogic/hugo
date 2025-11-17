#!/bin/bash

# Go to your Hugo site root
cd ~/github/whalelogic/ || exit

# Backup folder
BACKUP_DIR="content/posts_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "Backing up original posts to $BACKUP_DIR..."
find content/posts -type f -name "*.md" -exec cp {} "$BACKUP_DIR" \;

# Process each Markdown file
find content/posts -type f -name "*.md" | while read -r file; do
    first_line=$(head -n1 "$file")

    if [[ "$first_line" == "---" ]]; then
        # YAML front matter
        if grep -q '^date *= *' "$file"; then
            sed -i 's/^date *= */date: /' "$file"
            echo "Fixed date syntax in YAML front matter: $file"
        elif ! grep -q '^date:' "$file"; then
            mod_time=$(date -r "$file" +"%Y-%m-%dT%H:%M:%S%:z")
            sed -i "1a date: \"$mod_time\"" "$file"
            echo "Added date to YAML front matter: $file"
        fi
    elif [[ "$first_line" == "+++" ]]; then
        # TOML front matter
        if grep -q '^date:' "$file"; then
            sed -i 's/^date: */date = /' "$file"
            echo "Fixed date syntax in TOML front matter: $file"
        elif ! grep -q '^date *= *' "$file"; then
            mod_time=$(date -r "$file" +"%Y-%m-%dT%H:%M:%S%:z")
            sed -i "1a date = \"$mod_time\"" "$file"
            echo "Added date to TOML front matter: $file"
        fi
    else
        echo "Skipping $file: no recognized front matter"
    fi
done

echo "All done! Original posts are backed up in $BACKUP_DIR."
