#!/bin/bash

# List of departments (should match your groups/folders)
DEPARTMENTS=("doctors" "nurses" "adminstaff" "it" "lab" "hr" "billing")

echo "📄 Creating shared files for each department..."

for DEPT in "${DEPARTMENTS[@]}"; do
  FILE="/hospital/$DEPT/info.txt"

  # Create the file
  sudo touch "$FILE"

  # Add placeholder content
  echo "Confidential data for $DEPT department." | sudo tee "$FILE" > /dev/null

  # Set group ownership
  sudo chown :$DEPT "$FILE"

  # Set read/write for owner & group, nothing for others
  sudo chmod 660 "$FILE"

  echo "✅ Created and secured $FILE"
done

echo "🎉 All department files created and locked down."
