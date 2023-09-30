#!/system/bin/sh

script_parent_dir=$(dirname "$0")
current_datetime=$(date +"%Y-%m-%d_%H-%M-%S")

while true; do
    echo "Choose an option:"
    echo "1) Run ./Android_Active.sh"
    echo "2) Run ./Android_Inactive.sh"
    echo "3) Run ./Android_Active.sh followed by ./Android_Inactive.sh"
    echo "4) Exit"

    read choice

    case $choice in
        1)
            ./Android_Active.sh
            ;;
        2)
            ./Android_Inactive.sh
            ;;
        3)
            ./Android_Active.sh
            ./Android_Inactive.sh
            ;;
        4)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option. Try again."
            ;;
    esac
done