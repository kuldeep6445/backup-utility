#!/bin/bash

# Define variables
GITHUB_REPO="obsidianmd/obsidian-releases"
DOWNLOAD_DIR="/tmp/obsidian"

# Create download directory
mkdir -p $DOWNLOAD_DIR

# Get the latest release download URL for the .deb file
LATEST_URL=$(curl -s https://api.github.com/repos/$GITHUB_REPO/releases/latest | grep "browser_download_url.*\.deb" | cut -d '"' -f 4)

# Download the latest release
curl -L $LATEST_URL -o $DOWNLOAD_DIR/obsidian.deb

# Install the .deb file
sudo dpkg -i $DOWNLOAD_DIR/obsidian.deb

# Install any missing dependencies
sudo apt -y install -f

# Clean up
rm -rf $DOWNLOAD_DIR

echo "Obsidian installed successfully!"
