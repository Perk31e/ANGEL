#!/bin/sh

# check system architecture
getprop ro.product.cpu.abi
# dirname is command to extract directory path for file
# $0 means current file's name with path
script_parent_dir=$(dirname "$0")
current_datetime=$(date +"%Y-%m-%d_%H-%M-%S")
target_dir="$script_parent_dir/$current_datetime"

mkdir -p "$target_dir" || { echo "Failed to create directory"; exit 1; }

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

selected_options=""

while true; do
    echo "Choose options:"
    echo "1: Virtual Memory"
    echo "2: Network Info"
    echo "3: Process Info"
    echo "a: All options"
    echo "e: Exit"
    echo -n "Enter your choice (e.g. 1,2,3 or a or e): "
    read main_choice

    if [ "$main_choice" == "e" ]; then
        echo "Exiting."
        exit 0
    elif [ "$main_choice" == "a" ]; then
        main_choice="1,2,3"
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
            *) echo "Invalid option: $choice" ;;
        esac
    done

    displayed_options=""
    for option in 1 2 3; do
        if echo "$selected_options" | grep -q "$option,"; then
            displayed_options="${displayed_options}${option},"
        fi
    done

    echo ""
    echo -n "You have executed the following options: "
    echo $displayed_options
    echo "----------------------"
done