#!/bin/bash
current_dir=$(pwd)
owner=$(echo "$current_dir" | cut -d '/' -f3)

curr_path="/home/$owner"
cat data/stored_aliases "$curr_path/.bashrc" > temp && mv temp "$curr_path/.bashrc"