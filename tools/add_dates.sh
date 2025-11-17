#!/bin/bash

# Go to your Hugo site root
cd ~/github/whalelogic/ || exit

# Loop over all Markdown files in content/posts/
find content/posts -type f -name "*.md" | while read -r file; do
    first_line=$(head -n1 "$file")

    if [[ "$first_line" == "---" ]]; then
        # YAML front matter
        # Check for a line starting with "date"
        if grep -q '^date *= *' "$file"; then
            # Replace = with : for YAML
            sed -i 's/^date *= */date: /' "$file"
            echo "Fixed date syntax in YAML front matter: $file"
        elif ! grep -q '^date:' "$file"; then
            # Add missing date using file modification time
            mod_time=$(date -r "$file" +"%Y-%m-%dT%H:%M:%S%:z")
            sed -i "1a date: \"$mod_time\"" "$file"
            echo "Added date to YAML front matter: $file"
        fi
    elif [[ "$first_line" == "+++" ]]; then
        # TOML front matter
        # Check for a line starting with "date:" (YAML syntax accidentally used)
        if grep -q '^date:' "$file"; then
            # Replace : with = for TOML
            sed -i 's/^date: */date = /' "$file"
            echo "Fixed date syntax in TOML front matter: $file"
        elif ! grep -q '^date *= *' "$file"; then
            # Add missing date
            mod_time=$(date -r "$file" +"%Y-%m-%dT%H:%M:%S%:z")
            sed -i "1a date = \"$mod_time\"" "$file"
            echo "Added date to TOML front matter: $file"
        fi
    else
        echo "Skipping $file: no recognized front matter"
    fi
done
