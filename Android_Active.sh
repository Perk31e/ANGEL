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
    target_dir="$script_parent_dir/$current_datetime/Active_Data"
fi

mkdir -p "$target_dir" || { echo "Failed to create directory"; exit 1; }

echo -en $'\E[93m'
echo $'                         ..::::::::::::::..  .:'                               
echo $'                       .::::::::::--:.-:::::::::--==-.--:::.'                         
echo $'                 ..:---::---:::.    ..              .:--=-----:.'                     
echo $'               .-:--:---:                               ...:------.'                  
echo $'              :-.:==-.                                     .:-=-.:-:'                 
echo $'              ::.:=-.                                        .:+-..-.'                
echo $'              .-:::==-.                                      .===.:-.'                
echo $'                :--:---. ...                          .   :-=-:=::-.'                 
echo $'                  .---------:          ..          .:::=--::-=-:..'                   
echo $'                      .:::-.:===-:::---:.-:::::::::---.--::.'                         
echo $'                           :.   ..:::::::::::::::..   .'   

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

echo -en $'\E[37m'
echo $''
echo $' █████╗ ███╗   ██╗ ██████╗ ███████╗██╗          █████╗  ██████╗████████╗██╗██╗   ██╗███████╗'
echo $'██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║         ██╔══██╗██╔════╝╚══██╔══╝██║██║   ██║██╔════╝'
echo $'███████║██╔██╗ ██║██║  ███╗█████╗  ██║         ███████║██║        ██║   ██║██║   ██║█████╗  '
echo $'██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║         ██╔══██║██║        ██║   ██║╚██╗ ██╔╝██╔══╝  '
echo $'██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗    ██║  ██║╚██████╗   ██║   ██║ ╚████╔╝ ███████╗'
echo $'╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝    ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝'
                                                                                            

#ANSI SHADOW
#https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=ANGEL%20MAIN

# Function for Option 1: Virtual Memory
01_VirtualMemory() {
    echo
    echo "**********************************************"
    echo
    echo "             01 Virtual Memory "
    echo
    echo "**********************************************"
    echo
    VirtualMemory_Dir="$target_dir/01_VirtualMemory_info"
    mkdir -p "$VirtualMemory_Dir" || { echo "Failed to create VirtualMemory directory"; exit 1; }
    while true; do
        echo "Choose an option for Virtual Memory:"
        echo "a: Dump all PIDs"
        echo "s: Specify PIDs"
        echo "e: exit"
        echo -n "Enter your choice (a/s/e): "
        read choice
        case $choice in
            a)
                echo "Dumping heap for all PIDs"
                for line in $(ps -A | awk '{print $2","$9}'); do
                    pid=$(echo $line | cut -d',' -f1)
                    name=$(echo $line | cut -d',' -f2)
                    if [ "$pid" != "PID" ]; then
                        echo "Dumping heap for PID: $pid, Name: $name"
                        am dumpheap $pid $VirtualMemory_Dir/$name.hprof
                    fi
                done
                break
                ;;
            s)
                ps -A
                echo "Please refer to the above process list and specify PIDs."
                echo "Dumping heap for specified PIDs."
                echo -n "Enter PIDs separated by commas: "
                read input
                for pid in $(echo $input | tr "," "\n")
                do
                    name=$(ps -A | awk -v pid=$pid '$2 == pid {print $9}')
                    echo "Dumping heap for PID: $pid, Name: $name"
                    am dumpheap $pid $VirtualMemory_Dir/$name.hprof
                done
                break
                ;;
            e)
                echo "Skipping and doing nothing."
                break
                ;;
            *)
                echo "Invalid option. Choose 'a' for all PIDs or 's' for specific PIDs."
                ;;
        esac
    done
}
# Function for Option 2: Network info
02_NetworkInfo() {
    echo
    echo
    echo "**********************************************"
    echo
    echo "             02 Network info "
    echo
    echo "**********************************************"
    echo
    echo
    Network_Dir="$target_dir/02_Network_info"
    mkdir -p "$Network_Dir" || { echo "Failed to create Network directory"; exit 1; }
    # Collecting Network info
    echo "Collecting arp info"
    cat /proc/net/arp > "$Network_Dir/arp.txt"

    echo "collecting netstat result"
    netstat -anltup > "$Network_Dir/netstat.txt"

    echo "collecting network interface info"
    ifconfig > "$Network_Dir/ifconfig.txt"
    dumpsys wifi > "$Network_Dir/wifi.txt"
    cat /proc/net/dev > "$Network_Dir/network_interface.txt"

    echo "collecting route info"
    cat /proc/net/route > "$Network_Dir/route.txt"

    echo "collecting DNS info"
    getprop > "$Network_Dir/getprop.txt"

    echo "collecting iptables info"
    iptables -L -n -v > "$Network_Dir/iptables.txt"

    echo "collecting TCP/IP stack configuration info"
    sysctl -a 2>/dev/null > "$Network_Dir/sysctl.txt"

    echo "collecting network socket info"
    cat /proc/net/tcp > "$Network_Dir/socket_tcp.txt"
    cat /proc/net/udp > "$Network_Dir/socket_udp.txt"
}

# Function for Option 3: Process info
03_ProcessInfo() {
    echo
    echo
    echo "**********************************************"
    echo
    echo "             03 Process info "
    echo
    echo "**********************************************"
    echo
    echo
    Process_Dir="$target_dir/03_Process_info"
    mkdir -p "$Process_Dir" || { echo "Failed to create Process directory"; exit 1; }

    # Collecting process info
    echo "Collecting CPU Usage info"
    top -b -n 1 > "$Process_Dir/top.txt"

    echo "Collecting Process list"
    ps -A > "$Process_Dir/ps.txt"

    echo "Collecting file list opened by process"
    lsof > "$Process_Dir/lsof.txt" 

    echo "Collecting Activity process info"
    dumpsys activity processes > "$Process_Dir/dumpsys_activity_processes.txt"

    echo "Collecting process memory info"
    dumpsys meminfo > "$Process_Dir/dumpsys_meminfo.txt"

    # 사용자에게 strace를 실행할 시간을 물어보기
    echo -n "Enter the duration in minutes to run strace for each process (default is 10 seconds): "
    read duration
    # 사용자가 아무 값도 입력하지 않으면, 기본값 10초를 사용합니다.
    if [ -z "$duration" ]; then
        duration=0.1
    fi
    	echo "Choose an option:"
    	echo "a: Dump all PIDs"
    	echo "s: Specify PIDs"
    	echo "e: exit"
	echo -n "Enter your choice (a/s/e): "
	read choice

	while true; do
	    case $choice in
	        a)
	            echo "Performing strace and dumpsys meminfo for all PIDs"
	            for line in $(ps -A | awk '{print $2","$9}'); do
	            	pid_step3=$(echo $line | cut -d',' -f1)
		            name=$(echo $line | cut -d',' -f2)
		            if [ "$pid_step3" != "PID" ]; then
                    			echo "Performing strace for PID: $pid_step3, Name: $name for $duration minutes"
                    			timeout ${duration}m strace -p $pid_step3 &> "$Process_Dir/dumpsys_strace_$pid_step3.txt"

                    			echo "Performing dumpsys meminfo for PID: $pid_step3, Name: $name"
                    			dumpsys meminfo $pid_step3 > "$Process_Dir/dumpsys_meminfo_$pid_step3.txt"
                		fi
	            done
	            break
	            ;;
	        s)
	            ps -A
	            echo "Please refer to the above process list and specify PIDs."
	            echo "Performing strace and dumpsys meminfo for specified PIDs."
	            echo -n "Enter PIDs separated by commas: "
	            read input
	            for pid_step3 in $(echo $input | tr "," "\n")
	            do
	                name=$(ps -A | awk -v pid=$pid_step3 '$2 == pid {print $9}')
	                echo "Performing strace for PID: $pid_step3, Name: $name"
	                timeout ${duration}m strace -p $pid_step3 &> "$Process_Dir/dumpsys_strace_$pid_step3.txt"

	                echo "Performing dumpsys meminfo for PID: $pid_step3, Name: $name"
	                dumpsys meminfo $pid_step3 > "$Process_Dir/dumpsys_meminfo_$pid_step3.txt"
	            done
	            break
	            ;;
	        e)
	            echo "Skipping and doing nothing."
	            break
	            ;;
	        *)
            	echo "Invalid option. Choose 'a' for all PIDs or 's' for specific PIDs."
	            ;;
	    esac
    	done
}

# Function for Option 4: Logon user info
04_LogonUserInformation() {
    echo
    echo
    echo "**********************************************"
    echo
    echo "          04_Logon_User_Information "
    echo
    echo "**********************************************"
    echo
    echo
    LogonUser_Dir="$target_dir/04_Logon_User_Information"
    mkdir -p "$LogonUser_Dir" || { echo "Failed to create Logon User Information directory"; exit 1; }

    # echo "Contact info" 
    db_file="/data/data/com.android.providers.contacts/databases/contacts2.db"
    output_file="$LogonUser_Dir/contact.txt"

sqlite3 "$db_file" <<EOF > "$output_file"
.mode csv
.header on

SELECT
    c._id AS ContactID,
    r.display_name AS Name,
    d.data1 AS PhoneNumber
FROM
    contacts AS c
JOIN
    raw_contacts AS r ON c._id = r.contact_id
JOIN
    data AS d ON r._id = d.raw_contact_id
WHERE
    d.mimetype_id = (SELECT _id FROM mimetypes WHERE mimetype = 'vnd.android.cursor.item/phone_v2')
    AND d.data1 IS NOT NULL;

.quit
EOF

    echo "contact 정보가 저장되었습니다."

    # echo "mms info" 
    db_file="/data/data/com.android.providers.telephony/databases/mmssms.db"
    output_file="$LogonUser_Dir/mms.txt"

sqlite3 "$db_file" <<EOF > "$output_file"
.mode csv
.header on

SELECT -- sent message
    sms._id AS MessageID,
    sms.address AS SenderPhoneNumber,
    sms.body AS MessageContent,
    'Sent' AS MessageType
FROM
    sms
WHERE
    sms.type = 2 

UNION

SELECT -- receive message
    sms._id AS MessageID,
    sms.address AS ReceiverPhoneNumber,
    sms.body AS MessageContent,
    'Received' AS MessageType
FROM
    sms
WHERE
    sms.type = 1 
ORDER BY
    MessageID;

.quit
EOF

    echo "mms 정보가 저장되었습니다."


    echo "Image_Video info"
    source_directory="/sdcard/DCIM"
    destination_directory="$LogonUser_Dir/image_video"
    cp -r "$source_directory" "$destination_directory"


echo "App_Data info"

packages=$(pm list packages -a --user 0 | cut -d ':' -f 2)

while true; do
    echo "Choose an option for App Data:"
    echo "a: Dump all packages"
    echo "s: Specify packages"
    echo "e: Skip this step"
    echo -n "Enter your choice (a/s/e): "
    read choice

    case $choice in
        a)
            for package in $packages; do
                package_info=$(dumpsys package $package)
        
                # '.', '+', '-', ':', ';', '@', '[', ']'을 제외한 다른 특수 문자를 '_'로 변환
                safe_package=$(echo "$package" | sed 's/[^a-zA-Z0-9\.\+\-:;@\[\]]/_/g')
        
                mkdir -p "$LogonUser_Dir/$safe_package"
                output_file="$LogonUser_Dir/$safe_package/$safe_package.txt"
                echo "$package_info" > "$output_file"
        done
        echo "All packages info have been saved."
        ;;

        s)
            echo "Current running processes:"
            ps -A

            echo "Enter package names separated by commas followed by a space. For example: com.android.test1, com.android.test2"
            read specified_packages
            IFS=', '
            selected_packages=($specified_packages)
            for package in "${selected_packages[@]}"; do
                package_info=$(dumpsys package $package)
                safe_package=$(echo "$package" | sed 's/[^a-zA-Z0-9\.\+\-:;@\[\]]/_/g')
                mkdir -p "$LogonUser_Dir/$safe_package"
                output_file="$LogonUser_Dir/$safe_package/$safe_package.txt"
                echo "$package_info" > "$output_file"
            done
            break
            ;;
        e)
            echo "Skipped dumping packages."
            break
            ;;
        *)
            echo "Invalid choice. Try again."
            break
            ;;
    esac
done
echo "done"
}

# Function for Option 5: System info
05_SystemInformation() {
    echo
    echo
    echo "**********************************************"
    echo
    echo "            05_System_Information "
    echo
    echo "**********************************************"
    echo
    echo
    System_Dir="$target_dir/05_System_Information"
    mkdir -p "$System_Dir" || { echo "Failed to create System Information directory"; exit 1; }

    echo "Device info"
    cp /system/build.prop  $System_Dir/device_info_build.prop

    echo "cpu info"
    cat /proc/cpuinfo > "$System_Dir/cpu_info.txt"

    echo "memory info"
    cat /proc/meminfo > "$System_Dir/memory.txt"

    # echo "battery info"
    # 심볼릭 링크의 실제 경로 확인
    real_path=$(readlink -f /sys/class/power_supply/battery)

    # 저장할 파일 경로 지정 
    output_file="$System_Dir/battery"
    cp -r "$real_path" "$output_file"

    if [ $? -eq 0 ]; then  # 저장이 완료되면 메시지 표시
        echo "battery 내용을 파일에 저장했습니다."
    else
        echo "battery 저장 중 오류가 발생했습니다."
    fi
}

# Function for Option 6: Autoruns list
06_Autoruns_List() {
    echo
    echo
    echo "**********************************************"
    echo
    echo "               06_Autoruns_List "
    echo
    echo "**********************************************"
    echo
    echo

    AutorunsList_Dir="$target_dir/06_Autoruns_List"
    mkdir -p "$AutorunsList_Dir" || { echo "Failed to create Autoruns list directory"; exit 1; }

    pm list packages > $AutorunsList_Dir/app_list.txt 

    pm list packages -f | while read -r package; do
    package_path=$(echo "$package" | cut -d ':' -f 2)
    app_package=$(basename "$package_path")
    #echo "Checking $app_package..."

    # 앱 패키지 이름으로 앱 정보 추출
    app_info=$(dumpsys package "$app_package")

    # 자동 실행 항목 여부 확인 및 수집
    if echo "$app_info" | grep -q "Receiver Resolver Table"; then
        auto_start_info=$(echo "$app_info" | grep -A 3 "Receiver Resolver Table")
        echo "$auto_start_info" >> "$AutorunsList_Dir/auto_start_apps.txt"
    fi
    done

    # 자동 실행 항목 정보가 없을 경우 없음을 표기
    if [ ! -s "$AutorunsList_Dir/auto_start_apps.txt" ]; then
        echo "자동 실행 항목이 존재하지 않습니다." > "$AutorunsList_Dir/auto_start_apps.txt"
    fi

    echo "자동 실행 항목 정보 수집이 완료되었습니다."
}

# Function for Option 7: Clipboard
07_Clipboard() {
    echo
    echo "**********************************************"
    echo
    echo "                 07_Clipboard "
    echo
    echo "**********************************************"
    echo

    echo "Currently, we can only collect clipboard data from gboard."
    Clipboard_Dir="$target_dir/07_Clipboard"
    mkdir -p "$Clipboard_Dir" || { echo "Failed to create clipboard directory"; exit 1; }

    Clipboard_db_dir1="/data/user/0/com.google.android.inputmethod.latin/databases"
    Clipboard_db_dir2="/data/data/com.google.android.inputmethod.latin/databases"
    db_file_name="gboard_clipboard.db"
    
    if [ -d $Clipboard_db_dir1 ]; then
        if [ -f "$Clipboard_db_dir1/$db_file_name" ]; then
            cp "$Clipboard_db_dir1/$db_file_name" "$Clipboard_Dir/clipboard_data.db"
            echo "The clipboard data has been successfully collected."
            echo "You must open these files in DB viewer\n\n"
        else
            echo "gboard clipboard is not activated or the database does not exist."
            echo "Failed to collect clipboard data.\n\n"
        fi
    elif [ -d $Clipboard_db_dir2 ]; then
        if [ -f "$Clipboard_db_dir2/$db_file_name" ]; then
            cp "$Clipboard_db_dir2/$db_file_name" "$Clipboard_Dir/clipboard_data.db"
            echo "The clipboard data has been successfully collected."
            echo "You must open these files in DB viewer\n\n"
        else
            echo "gboard clipboard is not activated or the database does not exist."
            echo "Failed to collect clipboard data.\n\n"
        fi
    else 
        echo "gboard is not installed or the directory does not exist."
        echo "Failed to collect clipboard data.\n\n"
    fi
}


selected_options=""

while true; do
    echo "Choose options:"
    echo "1: Virtual Memory"
    echo "2: Network Info"
    echo "3: Process Info"
    echo "4: Logon User Info"
    echo "5: System Info"
    echo "6: Autoruns List"
    echo "7: Clipboard"
    echo "a: All options"
    echo "e: Exit"
    echo -n "Enter your choice (e.g. 1, 2, 3, 4 or a or e): "
    read main_choice

    if [ "$main_choice" == "e" ]; then
        echo "Exiting."
        exit 0
    elif [ "$main_choice" == "a" ]; then
        main_choice="1,2,3,4,5,6,7"
    fi

    old_ifs=$IFS
    IFS=','
    set -- $main_choice
    choices=("$@")
    IFS=$old_ifs

    for choice in "${choices[@]}"; do
        choice=$(echo $choice | tr -d ' ')  # 공백 제거
        case $choice in
            1) 01_VirtualMemory; selected_options="${selected_options}1," ;;
            2) 02_NetworkInfo; selected_options="${selected_options}2," ;;
            3) 03_ProcessInfo; selected_options="${selected_options}3," ;;
            4) 04_LogonUserInformation; selected_options="${selected_options}4," ;;
            5) 05_SystemInformation; selected_options="${selected_options}5," ;;
            6) 06_Autoruns_List; selected_options="${selected_options}6," ;;
            7) 07_Clipboard; selected_options="${selected_options}7," ;;
            *) echo "Invalid option: $choice" ;;
        esac
    done

    displayed_options=""
    for option in 1 2 3 4 5 6 7; do
        if echo "$selected_options" | grep -q "$option,"; then
            displayed_options="${displayed_options}${option},"
        fi
    done

    echo ""
    echo -n "You have executed the following options: "
    echo $displayed_options
    echo "----------------------"
done