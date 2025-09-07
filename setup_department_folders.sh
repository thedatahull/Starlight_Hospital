#!/bin/bash

# List of departments/groups
DEPARTMENTS=("doctors" "nurses" "adminstaff" "it" "lab" "hr" "billing")

echo "🏥 Setting up department folders..."

for DEPT in "${DEPARTMENTS[@]}"; do
  FOLDER="/hospital/$DEPT"

  # Create folder if it doesn't exist
  if [ ! -d "$FOLDER" ]; then
    sudo mkdir -p "$FOLDER"
    echo "📁 Created $FOLDER"
  else
    echo "ℹ️  $FOLDER already exists"
  fi

  # Set group ownership
  sudo chown :$DEPT "$FOLDER"

  # Set permissions
  sudo chmod 770 "$FOLDER"

  echo "✅ Set ownership and permissions for $FOLDER"
done

echo "🎉 Department folders are locked and loaded."
