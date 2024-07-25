#!/bin/bash
current_dir=$(pwd)
owner=$(echo "$current_dir" | cut -d '/' -f3)

curr_path="/home/$owner"
destination="data/dir"
directories=("Desktop" "Documents" "common" "Downloads")

for dir in "${directories[@]}"; do
    sudo rsync -a --info=progress2 "$curr_path/$dir" "$destination/"
done


