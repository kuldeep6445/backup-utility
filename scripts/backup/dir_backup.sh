#!/bin/bash
current_dir=$(pwd)
owner=$(echo "$current_dir" | cut -d '/' -f3)

curr_path="/home/$owner"

#sudo rsync -a --info=progress2 "$curr_path/Desktop" data/dir/
#sudo rsync -a --info=progress2 "$curr_path/Documents" data/dir/
sudo rsync -a --info=progress2 "$curr_path/common" data/dir/
#sudo rsync -a --info=progress2 "$curr_path/Downloads" data/dir/

