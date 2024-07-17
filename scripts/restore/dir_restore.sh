#!/bin/bash
current_dir=$(pwd)
owner=$(echo "$current_dir" | cut -d '/' -f3)

curr_path="/home/$owner"

#rsync -a --info=progress2 data/dir/Desktop ~/
#rsync -a --info=progress2 data/dir/Documents ~/
rsync -a --info=progress2 data/dir/common ~/
#rsync -a --info=progress2 data/dir/Downloads ~/