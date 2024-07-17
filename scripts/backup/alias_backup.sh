#!/bin/bash
current_dir=$(pwd)
owner=$(echo "$current_dir" | cut -d '/' -f3)

curr_path="/home/$owner"

head "$curr_path/.bashrc" -n 20 | grep alias > data/stored_aliases 