#!/bin/bash
current_dir=$(pwd)
owner=$(echo "$current_dir" | cut -d '/' -f3)

curr_path="/home/$owner"
source="data/dir"
directories=("Desktop" "Documents" "common" "Downloads")

# Function to calculate CRC32 checksum
crc32() {
    local file=$1
    crc32 "$file" 2>/dev/null | awk '{print $1}'
}

for dir in "${directories[@]}"; do
    src_dir="$source/$dir"
    dest_dir="$curr_path/$dir"

    # Ensure the destination directory exists
    mkdir -p "$dest_dir"

    # Find and compare CRC32 checksums of files
    find "$src_dir" -type f | while read -r src_file; do
        dest_file="$dest_dir${src_file#$src_dir}"
        if [ -f "$dest_file" ]; then
            src_crc=$(crc32 "$src_file")
            dest_crc=$(crc32 "$dest_file")
            if [ "$src_crc" != "$dest_crc" ]; then
                sudo rsync -a --info=progress2 "$src_file" "$dest_file"
            fi
        else
            sudo rsync -a --info=progress2 "$src_file" "$dest_file"
        fi
    done
done
