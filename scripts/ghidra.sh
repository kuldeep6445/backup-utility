#!/bin/bash

# Set the destination directory
DEST_DIR="$HOME/Documents"

# Get the latest release information from GitHub API
LATEST_RELEASE=$(curl -s https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest)

# Extract the download URL for the Linux version
DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | grep -o 'https://.*_PUBLIC_.*\.zip' | head -n 1)

# Extract the filename from the URL
FILENAME=$(basename "$DOWNLOAD_URL")

# Download the file
echo "Downloading $FILENAME..."
curl -L "$DOWNLOAD_URL" -o "$DEST_DIR/$FILENAME"

# Check if download was successful
if [ $? -eq 0 ]; then
    echo "Download completed successfully. File saved in $DEST_DIR/$FILENAME"
    
    # Extract the zip file
    echo "Extracting $FILENAME..."
    unzip "$DEST_DIR/$FILENAME" -d "$DEST_DIR"
    
    # Check if extraction was successful
    if [ $? -eq 0 ]; then
        echo "Extraction completed successfully."
        
        # Delete the zip file
        echo "Deleting $FILENAME..."
        rm "$DEST_DIR/$FILENAME"
        
        if [ $? -eq 0 ]; then
            echo "Zip file deleted successfully."
        else
            echo "Failed to delete the zip file."
        fi
    else
        echo "Extraction failed."
        exit 1
    fi
else
    echo "Download failed."
    exit 1
fi

echo "Ghidra has been downloaded, extracted, and the zip file has been deleted."