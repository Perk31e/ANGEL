#!/bin/sh

# check system architecture
getprop ro.product.cpu.abi

# dirname is command to extract directory path for file
# $0 means current file's name with path
script_parent_dir=$(dirname "$0")
current_datetime=$(date +"%Y-%m-%d_%H-%M-%S")

# Check if an argument was passed
if [ "$#" -gt 0 ]; then
    target_dir="$1"
else
    target_dir="$script_parent_dir/$current_datetime/InActive_Data"
fi

mkdir -p "$target_dir" || { echo "Failed to create directory"; exit 1; }

echo -en $'\E[32m'
echo $''
echo $'              ,***                                             ****'             
echo $'                ***                                           ***'               
echo $'                 ****                                       ****'                
echo $'                   ***        ,*******************,        ***'                  
echo $'                    *****************************************'                   
echo $'                   *******************************************'                  
echo $'               ***************************************************'              
echo $'            *********************************************************'           
echo $'          *************************************************************'         
echo $'        *****************************************************************'       
echo $'      **************    *********************************    **************'     
echo $'     **************      *******************************      **************'    
echo $'    ****************     *******************************,    ****************'   
echo $'   ***************************************************************************'  
echo $'  *****************************************************************************' 
echo $' *******************************************************************************'
echo $' *******************************************************************************'


echo -en $'\E[97m'
echo $''
echo $' █████╗ ███╗   ██╗ ██████╗ ███████╗██╗         ██╗███╗   ██╗ █████╗  ██████╗████████╗██╗██╗   ██╗███████╗'
echo $'██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║         ██║████╗  ██║██╔══██╗██╔════╝╚══██╔══╝██║██║   ██║██╔════╝'
echo $'███████║██╔██╗ ██║██║  ███╗█████╗  ██║         ██║██╔██╗ ██║███████║██║        ██║   ██║██║   ██║█████╗  '
echo $'██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║         ██║██║╚██╗██║██╔══██║██║        ██║   ██║╚██╗ ██╔╝██╔══╝  '
echo $'██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗    ██║██║ ╚████║██║  ██║╚██████╗   ██║   ██║ ╚████╔╝ ███████╗'
echo $'╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝    ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝'
                                                                                                         

01_Filesystem_Metadata() {
    # Create directory for each step
    echo "**********************************************"
    echo
    echo "             01 Filesystem Metadata "
    echo
    echo "**********************************************"

    FileMetadata_Dir="$target_dir/01_Filesystem_Metadata_info"
    mkdir -p "$FileMetadata_Dir" || { echo "Failed to create 01_Filesystem_Metadata_info directory"; exit 1; }

    #실행확인했으나 무한 작동,,,
    #find / -exec stat '{}' \;>stat.meta
    #find / -exec stat '{}' \; > "$FileMetadata_Dir/filesystem_metadata_info.txt"

    # 사용자로부터 duration 값을 입력 받습니다.
    echo "Enter duration (in minutes): "
    read duration
    timeout "${duration}m" find / -exec stat '{}' \; > "$FileMetadata_Dir/filesystem_metadata_info.txt"
}

02_System_User_Application_setting_Info() {
    echo "******************************************************************"
    echo
    echo "             02 System,User,Application Setting Information "
    echo
    echo "******************************************************************"

    SystemUserApplicationSetting_Dir="$target_dir/02_SystemUserAppli_Setting_info"
    mkdir -p "$SystemUserApplicationSetting_Dir" || { echo "Failed to create 02_SystemUserAppli_Setting_info directory"; exit 1; }

    #adb shell dumpsys 
    #activity 시스템 상태 확인
    dumpsys activity > "$SystemUserApplicationSetting_Dir/activity.txt"

    #최근에 사용한 #activity 시스템 상태만 확인
    dumpsys activity recents> "$SystemUserApplicationSetting_Dir/activity_recent.txt"

    #모든 계정에 대한 정보 표시
    dumpsys account > "$SystemUserApplicationSetting_Dir/account.txt"

    #cpu 프로세서 사용정보 확인
    dumpsys cpuinfo > "$SystemUserApplicationSetting_Dir/cpu_info.txt"

    #설치된 모든 앱 출력
    pm list packages > "$SystemUserApplicationSetting_Dir/app_list_info.txt"

    #list info on all apps
    dumpsys package packages > "$SystemUserApplicationSetting_Dir/all_apps_info.txt"
}

03_Log_Files() {
    echo "**********************************************"
    echo
    echo "             03 Log Files "
    echo
    echo "**********************************************"

    LogFile_Dir="$target_dir/03_Log_Files"
    mkdir -p "$LogFile_Dir" || { echo "Failed to create 03_Log_Files directory"; exit 1; }

    #adb shell dumpsys jobsechduler 실행
    dumpsys jobscheduler > "$LogFile_Dir/jobscheduler_info.txt"
    #if [!"dumpsys_jobscheduler.txt"];
    #then echo "jobscheduler is not in this device!"

    #이벤트 로그 
    # 사용자로부터 duration 값을 입력 받습니다.
    echo "Enter duration (in minutes): "
    read duration
    timeout "${duration}m" logcat -b events > "$LogFile_Dir/event_log_info.txt"
    #logcat -b events > "$LogFile_Dir/event_log_info.txt"
}

04_Recycle_Bin() {
    echo
    echo "**********************************************"
    echo
    echo "             04 Recycle Bin "
    echo
    echo "**********************************************"
    echo

    # Create a main directory for Recycle Bin
    RecycleBin_Dir="$target_dir/04_Recycle_Bin"
    mkdir -p "$RecycleBin_Dir" || { echo "Failed to create 04_Recycle_Bin directory"; exit 1; }

    # Paths for recycle bin sub-directories
    trash_dump_path="$RecycleBin_Dir/trash_dump"
    lf_dump_path="$RecycleBin_Dir/lf_dump"

    # Create sub-directories for 'trash' and 'lost+found'
    mkdir -p "$trash_dump_path" || { echo "Failed to create trash_dump directory"; exit 1; }
    mkdir -p "$lf_dump_path" || { echo "Failed to create lf_dump directory"; exit 1; }

    # Find and copy 'trash' and 'lost+found' to the corresponding sub-directories
    find / -type d -name '*trash*' -exec cp -Rn {} "$trash_dump_path" \; 2>/dev/null
    find / -type d -name '*lost+found*' -exec cp -Rn {} "$lf_dump_path" \; 2>/dev/null

    echo "Recycle Bin Data Dump Success"
}

06_Temp_File() {
    echo
    echo "**********************************************"
    echo
    echo "             06 Temp File "
    echo
    echo "**********************************************"
    echo

    # Create a main directory for Temp File
    Temp_File_Dir="$target_dir/06_Temp_File"
    mkdir -p "$Temp_File_Dir" || { echo "Failed to create main directory"; exit 1; }

    # Paths for temp file sub-directories
    cache_dump_path="$Temp_File_Dir/Cache"
    localtmp_dump_path="$Temp_File_Dir/LocalTmp"

    # Create sub-directories for 'cache' and '/data/local/tmp'
    mkdir -p "$cache_dump_path"
    mkdir -p "$localtmp_dump_path"

    # Find 'cache' directories and copy to cache_dump_path
    find /  -type d -name '*cache*' -exec cp -Rn {} "$cache_dump_path" \; 2>/dev/null

    # Copy '/data/local/tmp' to localtmp_dump_path
    cp -Rn /data/local/tmp/ "$localtmp_dump_path"

    echo "Temp File Data Dump Success"
}

07_External_Storage() {
    echo
    echo
    echo "**********************************************"
    echo
    echo "              07 External Storage "
    echo
    echo "**********************************************"
    echo
    echo


    External_Storage_Dir="$target_dir/07_External_Storage"
    mkdir -p "$External_Storage_Dir" || { echo "Failed to create 07_External_Storage directory"; exit 1; }

    lsusb > "$External_Storage_Dir/lsusb.txt"
    echo "\n!External Storage Done!\n"
}

08_Shortcut() {
    echo
    echo
    echo "**********************************************"
    echo
    echo "                08 ShortCut  "
    echo
    echo "**********************************************"
    echo
    echo

    ShortCut_Dir="$target_dir/08_ShortCut"
    mkdir -p "$ShortCut_Dir" || { echo "Failed to create 08_ShortCut directory"; exit 1; }

    cp -r /data/system_ce/0/shortcut_service  $ShortCut_Dir/
    echo "\n!ShortCut Done!\n"
}

selected_options=""

while true; do
    echo "Choose options:"
    echo "1: Filesystem Metadata"
    echo "2: System, User, Application Setting Information"
    echo "3: Log Files"
    echo "4: Recycle Bin"
    echo "6: Temp Files"
    echo "7: External Storage"
    echo "8: Shortcut"
    echo "a: All options"
    echo "e: Exit"
    echo -n "Enter your choice (e.g. 1, 2, 3, 4 or a or e): "
    read main_choice

    if [ "$main_choice" == "e" ]; then
        echo "Exiting."
        exit 0
    elif [ "$main_choice" == "a" ]; then
        main_choice="1,2,3,4,6,7,8"
    fi

    old_ifs=$IFS
    IFS=','
    set -- $main_choice
    choices=("$@")
    IFS=$old_ifs

    for choice in "${choices[@]}"; do
        choice=$(echo $choice | tr -d ' ')  # 공백 제거
        case $choice in
            1) 01_Filesystem_Metadata; selected_options="${selected_options}1," ;;
            2) 02_System_User_Application_setting_Info; selected_options="${selected_options}2," ;;
            3) 03_Log_Files; selected_options="${selected_options}3," ;;
            4) 04_Recycle_Bin; selected_options="${selected_options}4," ;;
            6) 06_Temp_File; selected_options="${selected_options}6," ;;
            7) 07_External_Storage; selected_options="${selected_options}7," ;;
            8) 08_Shortcut; selected_options="${selected_options}8," ;;
            *) echo "Invalid option: $choice" ;;
        esac
    done

    displayed_options=""
    for option in 1 2 3 4 6 7 8; do
        if echo "$selected_options" | grep -q "$option,"; then
            displayed_options="${displayed_options}${option},"
        fi
    done

    echo ""
    echo -n "You have executed the following options: "
    echo $displayed_options
    echo "----------------------"
done