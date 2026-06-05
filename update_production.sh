#!/bin/bash

# Configuration
PROJECT_DIR="/home/nutanix/plex-docker"
BUILDER_DIR="$PROJECT_DIR/builder"

echo "--- Tech Profile Builder Update Check: $(date) ---"

cd "$BUILDER_DIR" || { echo "Error: Could not enter $BUILDER_DIR"; exit 1; }

# Fetch latest state from GitHub
git fetch origin master

# Compare local head with remote head
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/master)

if [ "$LOCAL" != "$REMOTE" ]; then
    echo "Update available!"
    
    echo "1. Pulling latest code..."
    git pull origin master
    
    echo "2. Rebuilding and restarting container..."
    cd "$PROJECT_DIR" || exit
    docker compose up -d --build builder
    
    echo "Update complete."
else
    echo "Site is already up to date."
fi
