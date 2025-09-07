#!/bin/bash

# List of users to verify
USERS=(
  drsmith drjones drlee
  nralston ncarter nlewis
  areed ajohnson
  itadmin ittech1
  lwhite lgreen
  hrogers hmartinez
  bjones bturner
)

LOGFILE="/var/log/starlight_user_check.log"
sudo touch "$LOGFILE"
sudo chmod 600 "$LOGFILE"
echo "🔍 Running user setup checks..." | sudo tee "$LOGFILE"

for USER in "${USERS[@]}"; do
  echo "🔎 Checking $USER..." | sudo tee -a "$LOGFILE"
  
  # 1. Check user exists
  if id "$USER" &>/dev/null; then
    echo "✅ $USER exists." | sudo tee -a "$LOGFILE"
  else
    echo "❌ $USER does not exist!" | sudo tee -a "$LOGFILE"
    continue
  fi

  # 2. Check home directory
  if [ -d "/home/$USER" ]; then
    echo "✅ Home directory exists." | sudo tee -a "$LOGFILE"
  else
    echo "❌ Home directory missing!" | sudo tee -a "$LOGFILE"
  fi

  # 3. Check group membership
  GROUP=$(id -Gn "$USER")
  echo "📛 Groups: $GROUP" | sudo tee -a "$LOGFILE"

  # 4. Check department folder access
  # This assumes folder = /hospital/<dept> based on username pattern
  DEPT=$(echo "$USER" | grep -Eo '^(dr|n|a|it|l|h|b)' | sed \
    -e 's/^dr/doctors/' \
    -e 's/^n/nurses/' \
    -e 's/^a/adminstaff/' \
    -e 's/^it/it/' \
    -e 's/^l/lab/' \
    -e 's/^h/hr/' \
    -e 's/^b/billing/')

  if [ -d "/hospital/$DEPT" ]; then
    sudo -u "$USER" test -r "/hospital/$DEPT/info.txt" && \
      echo "✅ $USER can access /hospital/$DEPT" | sudo tee -a "$LOGFILE" || \
      echo "❌ $USER CANNOT access /hospital/$DEPT" | sudo tee -a "$LOGFILE"
  else
    echo "❓ Department folder /hospital/$DEPT not found." | sudo tee -a "$LOGFILE"
  fi

  echo "---" | sudo tee -a "$LOGFILE"
done

echo "✅ User check complete. See log: $LOGFILE"
