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
echo "                 Clipboard "
echo
echo "**********************************************"
echo
echo

Clipboard_Dir="$target_dir/Clipboard"
mkdir -p "$Clipboard_Dir" || { echo "Failed to create directory"; exit 1; }

source1="/data/user/0/com.google.android.inputmethod.latin/databases/gboard_clipboard.db"
source2="/data/data/com.google.android.inputmethod.latin/databases/gboard_clipboard.db"

if [ -f $source1 ]; then
    cp $source1 $Clipboard_Dir/clipboard_data.db
    echo "The clipboard data has been successfully collected.\n"
    echo "You must open these files in DB viewer\n\n"

elif [ -f $source2 ]; then
    cp $source2 $Clipboard_Dir/clipboard_data.db
    echo "The clipboard data has been successfully collected."
    echo "You must open these files in DB viewer\n\n"

else 
    echo "The clipboard file does not exist."
    echo "Failed to collect clipboard data.\n\n"
fi

# echo
# echo
# echo "**********************************************"
# echo
# echo "              Task Scheduler "
# echo
# echo "**********************************************"
# echo
# echo
# 
# 안드로이드 밖에서 실행
# 주현언니랑 동일해서 주석 처리
# adb shell dumpsys jobscheduler


echo
echo
echo "**********************************************"
echo
echo "              External Storage "
echo
echo "**********************************************"
echo
echo


External_Storage_Dir="$target_dir/External_Storage"
mkdir -p "$External_Storage_Dir" || { echo "Failed to create directory"; exit 1; }

lsusb > "$External_Storage_Dir/lsusb.txt"
echo "\n!External Storage Done!\n"


echo
echo
echo "**********************************************"
echo
echo "                  ShortCut  "
echo
echo "**********************************************"
echo
echo

ShortCut_Dir="$target_dir/ShortCut"
mkdir -p "$ShortCut_Dir" || { echo "Failed to create directory"; exit 1; }

cp -r /data/system_ce/0/shortcut_service  $ShortCut_Dir/
echo "\n!ShortCut Done!\n"
# dump  | grep 'android.widget.TextView' > "$ShortCut_Dir/widget.txt" => 조금 더 봐바야 할 듯