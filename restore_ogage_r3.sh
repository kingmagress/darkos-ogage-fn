#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_PATH="$SCRIPT_DIR/Ogage/ogage-original"

# Check if backup exists
if [ ! -f "$BACKUP_PATH" ]; then
    echo "Backup file not found at $BACKUP_PATH"
    exit 1
fi

echo "Stopping ogage service..."
sudo systemctl stop ogage.service

echo "Restoring ogage from backup..."
sudo cp -a "$BACKUP_PATH" /usr/local/bin/ogage

echo "Setting permissions..."
sudo chmod 777 /usr/local/bin/ogage

echo "Starting ogage service..."
sudo systemctl start ogage.service

echo "Restore complete."