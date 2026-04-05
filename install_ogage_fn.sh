#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_PATH="$SCRIPT_DIR/Ogage/ogage-original"

echo "Stopping ogage service..."
sudo systemctl stop ogage.service

echo "Checking for existing backup..."
if [ -f "$BACKUP_PATH" ]; then
    echo "Backup already exists, skipping..."
else
    echo "Backing up existing ogage binary..."
    sudo cp -a /usr/local/bin/ogage "$BACKUP_PATH"
    echo "Backup saved to $BACKUP_PATH"
fi

echo "Copying ogage binary to /usr/local/bin..."
sudo cp "$SCRIPT_DIR/Ogage/ogage-fn" /usr/local/bin/ogage

echo "Setting permissions..."
sudo chmod 777 /usr/local/bin/ogage

echo "Starting ogage service..."
sudo systemctl start ogage.service

echo "Done."