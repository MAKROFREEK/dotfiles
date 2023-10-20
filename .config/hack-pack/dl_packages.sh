#!/bin/bash

# Define the path to your packages.txt file
PACKAGES_FILE="packages.txt"

# Check if the file exists
if [ ! -f "$PACKAGES_FILE" ]; then
    echo "Error: $PACKAGES_FILE does not exist."
    exit 1
fi

# Read the file line by line and install non-commented packages with yay
while read -r line; do
    # Skip lines starting with '#'
    if [[ $line == \#* ]]; then
        continue
    fi

    # Trim leading and trailing whitespace
    package_name=$(echo "$line" | xargs)

    # Check if the package name is not empty
    if [ -n "$package_name" ]; then
        echo "Installing $package_name with yay..."
        yay -S --noconfirm "$package_name"
    fi
done < "$PACKAGES_FILE"

