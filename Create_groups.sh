#!/bin/bash

# Starlight General Hospital - Department Group Setup

# List of hospital departments (Linux groups)
groups=("doctors" "nurses" "adminstaff" "lab" "hr" "billing" "it")

echo "🛠️ Creating hospital department groups..."
for group in "${groups[@]}"; do
    if getent group "$group" > /dev/null; then
        echo "Group already exists: $group"
    else
        groupadd "$group"
        echo "✅ Created group: $group"
    fi
done

echo "✅ All department groups have been created."
