#!/bin/bash

# List of users to update passwords for
USERS=(
  drsmith drjones drlee
  nralston ncarter nlewis
  areed ajohnson
  itadmin ittech1
  lwhite lgreen
  hrogers hmartinez
  bjones bturner
)

DEFAULT_PASSWORD="Starlight123!"  # You can change this

echo "🔐 Setting passwords for users..."
LOGFILE="/var/log/starlight_password_set.log"
sudo touch "$LOGFILE"
sudo chmod 600 "$LOGFILE"

for USER in "${USERS[@]}"; do
  if id "$USER" &>/dev/null; then
    echo "$USER:$DEFAULT_PASSWORD" | sudo chpasswd
    echo "$(date): ✅ Password set for $USER" | sudo tee -a "$LOGFILE" > /dev/null
  else
    echo "$(date): ❌ User $USER does not exist. Skipping." | sudo tee -a "$LOGFILE" > /dev/null
  fi
done

echo "✅ All done. Check log: $LOGFILE"
