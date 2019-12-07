#!/bin/bash

#formatting variables
RED='\033[0;41;30m'
STD='\033[0;0;39m'
currentdir=$(pwd)

upscript()
{
    echo "Updating script..."
    cd ..
    rm -r linux
    rm -r linux-master
    clear
    echo "Updating script..."
    git clone https://github.com/bluefish9981/linux.git
    sleep 1
}

chmoddir()
{
    find "$currentdir" -type d -exec chmod 777 {} \;
    find "$currentdir" -type f -exec chmod 777 {} \;
    echo ""
    echo "Writing permissions..."
    sleep 1
    start 0 8
}

#installs dependencies
installdependencies()
{
    echo "Installing dependencies..."
    sudo apt-get install xterm -y | grep "random bullshit"
    sudo apt-get install ufw -y | grep "random bullshit"
    echo "Done!"
    sleep 1
}

#username prompt
promptuname()
{
    echo -n "Enter the username and press [ENTER]: "
    read uname
    echo $uname > username
}

#password prompt
promptpasswd()
{
    echo "Enter the password (matching "
    echo -n "user) and press [ENTER]: "
    read -s passwd
    echo $passwd > password
}

#reads the user-submitted username and password, displayed when needed (info menu so far)
displayuserinfo()
{
    local uname
    local passwd
    passwd=$(head -n 1 password)
    uname=$(head -n 1 username)
    echo "Current info, username: $uname | password: $passwd"
    echo ""
}

#opens terminal, accepts one command and argument
newterminal()
{
    xterm -e "$1" "$2"
}

#checks information about current release
#options include saving the output to the Desktop
#should work for both debian and ubuntu
checkrelease()
{
    username=$(head -n 1 username)
    local FILE1
    local FILE2
    FILE1=/etc/os-release
    FILE2=/etc/lsb-release
    if test -f "$FILE1"
    then
        if [ "$1" = "1" ]
        then
            cat $FILE1 > /home/$username/Desktop/release_info
            echo "Saving to /home/$username/Desktop/release_info"
        else
            cat $FILE1
        fi
    elif test -f "$FILE2"
    then
        if [ "$1" = "1" ]
        then
            cat $FILE2 > /home/$username/Desktop/release_info
            echo "Saving to /home/$username/Desktop/release_info"
        else
            cat $FILE2
        fi
    else
        echo "Release info not found"
    fi
}

#displays banner
banner()
{
    echo "   ____      _               ____  _             _   
  / ___|   _| |__   ___ _ __| __ )| |_   _  __ _| |_ 
 | |  | | | | '_ \ / _ \ '__|  _ \| | | | |/ _\` | __|
 | |__| |_| | |_) |  __/ |  | |_) | | |_| | (_| | |_ 
  \____\__, |_.__/ \___|_|  |____/|_|\__, |\__,_|\__|
       |___/                         |___/           "
    echo ""
}

#shows options for info menu
infomenu()
{
    clear
    banner
    displayuserinfo
    echo "1) Set Password"
    echo "2) Set Username"
    echo "3) Both"
    echo "4) Back"
    echo "5) Exit"
}

#reads input for release menu
readinfo()
{
    local choice
	read -p "Enter choice [ 1 - 5 ] " choice
	case $choice in
		1) promptpasswd && sleep 1 && info ;;
		2) promptuname && sleep 1 && info ;;
        3) setallinfo && info;;
        4) start 0 3 ;;
		5) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2 && info
	esac
}

#calls info functions
info()
{
    infomenu
    readinfo
}

#shows options for release menu
releasemenu()
{
    clear
    banner
    echo "1) Output current release info"
    echo "2) Save current release info to Desktop"
    echo "3) Both"
    echo "4) Back"
    echo "5) Exit"
}

#reads input for release menu
readrelease()
{
    local choice
	read -p "Enter choice [ 1 - 5 ] " choice
	case $choice in
		1) releasemenu && echo "" && checkrelease && echo ""  && readrelease ;;
		2) releasemenu && echo "" && checkrelease 1 && echo ""  && readrelease ;;
        3) releasemenu && echo "" && checkrelease && echo "" && checkrelease 1 && echo ""  && readrelease ;;
        4) start ;;
		5) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2 && release
	esac
}

#calls release functions
release()
{
    releasemenu
    readrelease
}

#will eventually do everything for you
auto()
{
    newterminal ./update.sh "1" & newterminal ./release.sh & newterminal ./rmmedia.sh & start 0 2
}

#shows options for main menu
mainmenu()
{
    clear
    banner

    if [ "$1" = "1" ]
    then
        echo "MSG: Dependencies installed."
        echo ""
    elif [ "$1" = "2" ]
    then
        echo "MSG: Ready"
        echo ""
    elif [ "$1" = "3" ]
    then
        local uname
        local passwd
        passwd=$(head -n 1 password)
        uname=$(head -n 1 username)
        echo "Current info, username: $uname | password: $passwd"
        echo ""
    elif [ "$1" = "4" ]
    then
        echo "MSG: Blacklisted packages (being) removed"
        echo ""
    elif [ "$1" = "5" ]
    then
        echo "MSG: Media files (being) removed"
        echo ""
    elif [ "$1" = "6" ]
    then
        echo "MSG: Machine updated"
        echo ""
    elif [ "$1" = "7" ]
    then
        echo "MSG: Firewall installation verified and firewall enabled"
        echo ""
    elif [ "$1" = "8" ]
    then
        echo "MSG: Permissions modified"
        echo ""
    fi
    
    echo "1) Install dependencies"
    echo "2) Auto"
    echo "3) Set user info"
    echo "4) Update"
    echo "5) Firewall"
    echo "6) Remove media files"
    echo "7) Remove blacklisted packages"
    echo "8) Check release"
    echo "9) Chmod the script"
    echo "10) Exit"
}

#reads input for main menu
readmain(){
	local choice
	read -p "Enter choice [ 1 - 9 ] " choice
	case $choice in
		1) installdependencies && start 0 1 ;;
        2) auto ;;
		3) info ;;
        4) newterminal ./update.sh & start 0 6;;
        5) newterminal ./ufw.sh & start 0 7 ;;
        6) newterminal ./rmmedia.sh & start 0 5 ;;
        7) newterminal ./rmblacklist.sh & start 0 4 ;;
        8) release ;;
        9) chmoddir ;;
		10) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2 && start
	esac
}

#asks dor all info
setallinfo()
{
    promptuname && promptpasswd && sleep 1
}

#yes or no prompt
yesorno()
{
    if [ $2 = "1" ]
    then
        echo ""
        echo "Do you want to change user info?"
    fi
    echo "1) Yes"
    echo "2) No"
    echo ""
    local choice
	read -p "[ 1 or 2 ]: " choice
    echo ""
	case $choice in
		1) "$1" ;;
		2) echo "Continuing..." && sleep 2 ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2 && clear && displayuserinfo && yesorno setallinfo 1 && mainmenu 3 && readmain ;;
	esac
}

#starts important functions(dependency installer and 
#initializes the main menu and the maim menu input reader)
start()
{
    if [ "$1" = "1" ]
    then
        installdependencies
        echo ""
        displayuserinfo
        yesorno setallinfo 1
        mainmenu 3
        readmain
    else
    mainmenu "$2"
    readmain
    fi
}

#master function, everything branches from this call
start 1 2
#test functions:

upscript
#chmoddir
#newterminal sudo ./rmblacklist.sh
#newterminal
#mainmenu
#readmain
#promptuname
#promptpasswd
#checkrelease
#checkrelease 1
#rmblacklist
