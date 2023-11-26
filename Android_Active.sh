#!/system/bin/sh

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
# Declare a global variable to track whether the 'ps -A' command has been checked.
ps_checked=0
ps_command=""

# Check if 'ps -A' command works
CheckPsCommand() {
    # Check if the 'ps -A' command has already been checked.
    if [ $ps_checked -eq 0 ]; then
        # Attempt the 'ps -A' command.
        ps -A 2>/dev/null
        if [ $? -ne 0 ]; then
            # 'ps -A' failed, use 'ps' instead
            ps_command="ps"
            echo "This environment does not support 'ps -A'. Executing with 'ps' command instead."
            echo.
        else
            # 'ps -A' succeeded
            ps_command="ps -A"
        fi
        # Record the execution status of the 'ps -A' command.
        ps_checked=1
    fi
}

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

FridaServer() {
    while true; do
        echo "Do you want to run the frida server in the background to perform a virtual memory dump? (y/n)"
        read answer

        case "$answer" in
            [Yy]* )
                # Determine the architecture
                arch=$(getprop ro.product.cpu.abi)
                frida_server="./frida-server-16.1.4-android-x86_64"

                if [ "$arch" = "x86" ]; then
                    frida_server="./frida-server-16.1.4-android-x86"
                elif [[ "$arch" == *"arm64"* ]]; then 
                    frida_server="./frida-server-16.1.4-android-arm64"
                elif [[ "$arch" == *"arm"* ]]; then 
                    frida_server="./frida-server-16.1.4-android-arm"
                fi

                # Try to start the Frida server
                $frida_server &

                # Wait a little to capture the output of the last command
                sleep 2

                # Check the error message
                if dmesg | tail -n 10 | grep -q "Unable to load SELinux policy"; then
                    echo "It seems there's an issue with SELinux. Trying to set it to permissive mode..."
            
                    # Attempt to set SELinux to permissive mode
                    setenforce 0
            
                    # Inform the user
                    echo "SELinux mode is set to permissive temporarily. Starting the Frida server again..."
            
                    # Start the Frida server again
                    ./frida-server-16.1.4-android-x86_64 &
                fi

                echo "frida-server is running in the background. Once you've finished with fridump3, press 'c' to continue."
                while :; do
                    read continue_key
                    if [ "$continue_key" = "c" ] || [ "$continue_key" = "C" ]; then
                        pkill frida-server
                        break
                    fi
                done
                break
                ;;
            [Nn]* )
                echo "Skipped starting the Frida server."
                break
                ;;
            * )
                echo "Please answer yes or no"
                ;;
        esac
    done
}
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

    FridaServer
    CheckPsCommand

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
                if [ "$ps_command" = "ps -A" ]; then
                    for line in $($ps_command | awk '{print $2","$9}'); do
                        pid_step1=$(echo $line | cut -d',' -f1)
                        name=$(echo $line | cut -d',' -f2)
                        if [ "$pid_step1" != "PID" ] && [ -n "$name" ]; then
                            echo "Dumping heap for PID: $pid_step1, Name: $name"
                            am dumpheap $pid_step1 $VirtualMemory_Dir/$name.hprof
                        else
                            echo "Skipping PID: $pid_step1 with no valid name"
                        fi
                    done
                else
                    for line in $($ps_command | awk '{print $2","$8}'); do
                        pid_step1=$(echo $line | cut -d',' -f1)
                        name=$(echo $line | cut -d',' -f2)
                        if [ "$pid_step1" != "PID" ] && [ -n "$name" ]; then
                            echo "Dumping heap for PID: $pid_step1, Name: $name"
                            am dumpheap $pid_step1 $VirtualMemory_Dir/$name.hprof
                        else
                            echo "Skipping PID: $pid_step1 with no valid name"
                        fi
                    done
                fi
                break
                ;;

            s)
                $ps_command
                echo "Please refer to the above process list and specify PIDs."
                echo "Dumping heap for specified PIDs."
                echo -n "Enter PIDs separated by commas: "
                read input
                for pid_step1 in $(echo $input | tr "," "\n")
                do
                    if [ "$ps_command" = "ps -A" ]; then
                        name=$($ps_command | awk -v pid=$pid_step1 '$2 == pid {print $9}')
                    else
                        name=$($ps_command | awk -v pid=$pid_step1 '$2 == pid {print $8}')
                    fi
                    echo "Dumping heap for PID: $pid_step1, Name: $name"
                    am dumpheap $pid_step1 $VirtualMemory_Dir/$name.hprof
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

    echo "collecting system/network properties info"
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
    CheckPsCommand
    Process_Dir="$target_dir/03_Process_info"
    mkdir -p "$Process_Dir" || { echo "Failed to create Process directory"; exit 1; }

    # Collecting process info
    echo "Collecting CPU Usage info"
    top -b -n 1 > "$Process_Dir/top.txt"

    echo "Collecting Process list"
    $ps_command > "$Process_Dir/ps.txt"

    echo "Collecting file list opened by process"
    lsof > "$Process_Dir/lsof.txt" 

    echo "Collecting Activity process info"
    dumpsys activity processes > "$Process_Dir/dumpsys_activity_processes.txt"

    echo "Collecting process memory info"
    dumpsys meminfo > "$Process_Dir/dumpsys_meminfo.txt"

    # Ask the user for the duration to run strace
    echo -n "Enter the duration in minutes to run strace for each process (default is 10 seconds): "
    read duration
    # If the user enters no value, use the default value of 10 seconds.
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
                if [ "$ps_command" = "ps -A" ]; then
                    for line in $($ps_command | awk '{print $2","$9}'); do
                        pid_step3=$(echo $line | cut -d',' -f1)
                        name=$(echo $line | cut -d',' -f2)
                        if [ "$pid_step3" != "PID" ]; then
                            echo "Performing strace for PID: $pid_step3, Name: $name for $duration minutes"
                            timeout ${duration}m strace -p $pid_step3 &> "$Process_Dir/dumpsys_strace_$pid_step3.txt"

                            echo "Performing dumpsys meminfo for PID: $pid_step3, Name: $name"
                            dumpsys meminfo $pid_step3 > "$Process_Dir/dumpsys_meminfo_$pid_step3.txt"
                        fi
                    done
                else
                    for line in $($ps_command | awk '{print $2","$8}'); do
                        pid_step3=$(echo $line | cut -d',' -f1)
                        name=$(echo $line | cut -d',' -f2)
                        if [ "$pid_step3" != "PID" ]; then
                            echo "Performing strace for PID: $pid_step3, Name: $name for $duration minutes"
                            timeout ${duration}m strace -p $pid_step3 &> "$Process_Dir/dumpsys_strace_$pid_step3.txt"

                            echo "Performing dumpsys meminfo for PID: $pid_step3, Name: $name"
                            dumpsys meminfo $pid_step3 > "$Process_Dir/dumpsys_meminfo_$pid_step3.txt"
                        fi
                    done
                fi
                break
                ;;
	        s)
	            $ps_command
	            echo "Please refer to the above process list and specify PIDs."
	            echo "Performing strace and dumpsys meminfo for specified PIDs."
	            echo -n "Enter PIDs separated by commas: "
	            read input
	            for pid_step3 in $(echo $input | tr "," "\n")
	            do
	                if [ "$ps_command" = "ps -A" ]; then
                        name=$($ps_command | awk -v pid=$pid_step3 '$2 == pid {print $9}')
                    else
                        name=$($ps_command | awk -v pid=$pid_step3 '$2 == pid {print $8}')
                    fi
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

    # Check if sqlite3 exists
    if command -v sqlite3 >/dev/null 2>&1; then
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

    if [ $? -eq 0 ]; then
        echo "Contact info saved."
    else
        echo "Error: Failed to save contact info."
    fi

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

        if [ $? -eq 0 ]; then
            echo "MMS info saved."
        else
            echo "Error: Failed to save MMS info."
        fi

    else
        echo "sqlite3 not found. Dumping database files directly."

        # Dumping the two contact database files
        cp "/data/data/com.samsung.android.providers.contacts/databases/contacts2.db" "$LogonUser_Dir/contacts2_data_data.db"
        cp "/data/user/0/com.samsung.android.providers.contacts/databases/contacts2.db" "$LogonUser_Dir/contacts2_data_user.db"
    fi

    echo "Image_Video info"
    source_directory="/sdcard/DCIM"
    destination_directory="$LogonUser_Dir/image_video"
    if cp -r "$source_directory" "$destination_directory"; then
        echo "Image and video info copied successfully."
    else
        echo "Error: Failed to copy image and video info."
    fi

    echo "App_Data info"
    packages=$(pm list packages -a --user 0 | cut -d ':' -f 2)

    for package in $packages; do
        package_info=$(dumpsys package $package)
        safe_package=$(echo "$package" | sed 's/[^a-zA-Z0-9\.\+\:;@\[\]-]/_/g')
        mkdir -p "$LogonUser_Dir/$safe_package"
        output_file="$LogonUser_Dir/$safe_package/$safe_package.txt"
        if echo "$package_info" > "$output_file"; then
            echo "Package info for $package saved."
        else
            echo "Error: Failed to save package info for $package."
        fi
    done

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

                # Check if package_info contains meaningful data
                if [ -z "$package_info" ] || [[ $package_info == *"not found"* ]]; then
                    echo "No information found for package: $package"
                    continue
                fi

                # Convert all special characters to '_' except for '.', '+', '-', ':', ';', '@', '[', and ']'
                safe_package=$(echo "$package" | sed 's/[^a-zA-Z0-9\.\+\:;@\[\]-]/_/g')

                mkdir -p "$LogonUser_Dir/$safe_package" || { echo "Failed to create directory for $safe_package"; continue; }
                output_file="$LogonUser_Dir/$safe_package/$safe_package.txt"
    
                # Try to save the package info and check for errors
                if ! echo "$package_info" > "$output_file"; then
                    echo "Failed to save package info for $package"
                else
                    echo "Package info for $package saved successfully."
                fi
            done
            echo "All attempted package info saves have been processed."
            ;;


        s)
            CheckPsCommand
            echo "Current running processes:"
            $ps_command

            echo "Enter package names separated by commas followed by a space. For example: com.android.test1, com.android.test2"
            read specified_packages
            IFS=', '
            selected_packages=($specified_packages)
            for package in "${selected_packages[@]}"; do
                package_info=$(dumpsys package $package)

                # Check if package_info contains meaningful data
                if [ -z "$package_info" ] || [[ $package_info == *"not found"* ]]; then
                    echo "No information found for package: $package"
                    continue
                fi

                safe_package=$(echo "$package" | sed 's/[^a-zA-Z0-9\.\+\:;@\[\]-]/_/g')
                mkdir -p "$LogonUser_Dir/$safe_package" || { echo "Failed to create directory for $safe_package"; continue; }
                output_file="$LogonUser_Dir/$safe_package/$safe_package.txt"
                echo "$package_info" > "$output_file"
                echo "Package info for $package saved successfully."
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
    # check out symbolic link's real path
    real_path=$(readlink -f /sys/class/power_supply/battery)

    # specify file's path to save
    output_file="$System_Dir/battery"
    cp -r "$real_path" "$output_file"

    if [ $? -eq 0 ]; then  # Display message upon completion of saving
        echo "The content of battery has been saved to the file."
    else
        echo "An error occurred while saving the battery."
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

    # Extract app information using the app package name
    app_info=$(dumpsys package "$app_package")

    # Check and collect information on auto-run items
    if echo "$app_info" | grep -q "Receiver Resolver Table"; then
        auto_start_info=$(echo "$app_info" | grep -A 3 "Receiver Resolver Table")
        echo "$auto_start_info" >> "$AutorunsList_Dir/auto_start_apps.txt"
    fi
    done

    # In case of no information on auto-run items, mark as none
    if [ ! -s "$AutorunsList_Dir/auto_start_apps.txt" ]; then
        echo "No auto-run items exist." > "$AutorunsList_Dir/auto_start_apps.txt"
    fi

    # We have added the Frida server for apps like com.samsung.android.app.routines to perform scheduled tasks
    FridaServer
    echo "Auto-run item information collection has been completed."
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
        choice=$(echo $choice | tr -d ' ')
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