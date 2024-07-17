#!/bin/bash

# finding user name
current_dir=$(pwd)
owner=$(echo "$current_dir" | cut -d '/' -f3)

curr_path="/home/$owner"
# Variables
DOWNLOAD_URL="https://tlauncher.org/jar"
TEMP_DIR="/tmp/tlauncher_download"
TARGET_DIR="$curr_path/Documents"

# Create temporary directory
mkdir -p "$TEMP_DIR"

# Download TLauncher
echo "Downloading TLauncher..."
wget -P "$TEMP_DIR" "$DOWNLOAD_URL"

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Download failed!"
    exit 1
fi

# Find the downloaded zip file
ZIP_FILE=$(ls "$TEMP_DIR" | grep -i ".zip$")

if [ -z "$ZIP_FILE" ]; then
    echo "No zip file found in the download directory!"
    exit 1
fi

ZIP_PATH="$TEMP_DIR/$ZIP_FILE"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Unzip the downloaded file
echo "Unzipping TLauncher..."
unzip -o "$ZIP_PATH" -d "$TARGET_DIR"

# Check if the unzipping was successful
if [ $? -ne 0 ]; then
    echo "Unzipping failed!"
    exit 1
fi

# Check if TLauncher.jar exists in the target directory
if [ -f "$TARGET_DIR/TLauncher.jar" ]; then
    echo "TLauncher.jar successfully extracted to $TARGET_DIR"
else
    echo "TLauncher.jar not found in the extracted files!"
    exit 1
fi

# Clean up
rm -r "$TEMP_DIR"
echo "Clean up done."

echo "TLauncher setup complete."
