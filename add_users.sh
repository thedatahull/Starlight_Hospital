#!/bin/bash

# Define users and their corresponding groups
declare -A USERS
USERS=(
  [drsmith]=doctors
  [drjones]=doctors
  [drlee]=doctors

  [nralston]=nurses
  [ncarter]=nurses
  [nlewis]=nurses

  [areed]=adminstaff
  [ajohnson]=adminstaff

  [itadmin]=it
  [ittech1]=it

  [lwhite]=lab
  [lgreen]=lab

  [hrogers]=hr
  [hmartinez]=hr

  [bjones]=billing
  [bturner]=billing
)

echo "🔧 Creating users and assigning to groups..."

for USER in "${!USERS[@]}"; do
  GROUP="${USERS[$USER]}"

  if id "$USER" &>/dev/null; then
    echo "⚠️  User '$USER' already exists. Skipping."
  else
    sudo useradd -m -s /bin/bash "$USER"
    echo "✅ User '$USER' created."
  fi

  # Assign to group (whether they existed already or not)
  if getent group "$GROUP" > /dev/null; then
    sudo usermod -aG "$GROUP" "$USER"
    echo "➡️  User '$USER' added to group '$GROUP'."
  else
    echo "❌ Group '$GROUP' does not exist! Skipping group assignment for '$USER'."
  fi

done
