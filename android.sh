#!/bin/sh
# dirname is command to extract directory path for file
# $0 means current file's name with path
script_parent_dir=$(dirname "$0")
current_datetime=$(date +"%Y-%m-%d_%H-%M-%S")
target_dir="$script_parent_dir/$current_datetime"

# Create directory name with date
# mkdir -p option means if directory already exists ignore then proceed next instruction
mkdir -p "$target_dir" || { echo "Failed to create directory"; exit 1; }

# Create directory for each step
echo
echo
echo "**********************************************"
echo
echo "                ClipBoard "
echo
echo "**********************************************"
echo
echo



echo
echo
echo "**********************************************"
echo
echo "              Task Scheduler "
echo
echo "**********************************************"
echo
echo

echo
echo
echo "**********************************************"
echo
echo "              External Storage "
echo
echo "**********************************************"
echo
echo

lsusb > "$target_dir/lsusb.txt"

echo
echo
echo "**********************************************"
echo
echo "                  ShortCut  "
echo
echo "**********************************************"
echo
echo

cat /data/system/shortcut_service.xml > "$target_dir/shortcut.txt"
echo -e "\n\n\n">> "$target_dir/shortcut.txt"
find "/data/system_ce/0/shortcut_service" -type f -exec cat {} \; -exec echo -e "\n\n\n" \; >> "$target_dir/shortcut.txt"