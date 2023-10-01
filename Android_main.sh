#!/system/bin/sh

script_parent_dir=$(dirname "$0")
current_datetime=$(date +"%Y-%m-%d_%H-%M-%S")
target_dir="$script_parent_dir/$current_datetime"

#echo -en $'\E[33m'
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


echo -en $'\E[97m'
echo $''
echo $' █████╗ ███╗   ██╗ ██████╗ ███████╗██╗         ███╗   ███╗ █████╗ ██╗███╗   ██╗'
echo $'██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║         ████╗ ████║██╔══██╗██║████╗  ██║'
echo $'███████║██╔██╗ ██║██║  ███╗█████╗  ██║         ██╔████╔██║███████║██║██╔██╗ ██║'
echo $'██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║         ██║╚██╔╝██║██╔══██║██║██║╚██╗██║'
echo $'██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗    ██║ ╚═╝ ██║██║  ██║██║██║ ╚████║'
echo $'╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝'

#ANSI SHADOW
#https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=ANGEL%20MAIN
while true; do
    echo "Choose an option:"
    echo "1) Run ./Android_Active.sh"
    echo "2) Run ./Android_Inactive.sh"
    echo "3) Run ./Android_Active.sh followed by ./Android_Inactive.sh"
    echo "4) Exit"

    read choice

    case $choice in
        1)
            mkdir -p "$target_dir/Active_Data" || { echo "Failed to create directory"; exit 1; }
            ./Android_Active.sh $target_dir/Active_Data
            ;;
        2)
            mkdir -p "$target_dir/InActive_Data" || { echo "Failed to create directory"; exit 1; }
            ./Android_Inactive.sh $target_dir/InActive_Data
            ;;
        3)
            mkdir -p "$target_dir/Active_Data" || { echo "Failed to create directory"; exit 1; }
            ./Android_Active.sh $target_dir/Active_Data
            mkdir -p "$target_dir/InActive_Data" || { echo "Failed to create directory"; exit 1; }
            ./Android_Inactive.sh $target_dir/InActive_Data
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