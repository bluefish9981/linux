#!/bin/bash

#formatting variables
RED='\033[0;41;30m'
STD='\033[0;0;39m'

#installs dependencies
installdependencies()
{
    echo "Installing dependencies..."
    sudo apt-get install gnome-terminal -y | grep "random bullshit"
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
    gnome-terminal -e "$1" "$2"
    echo "Command $1 $2 running in new terminal"
    sleep 5
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

#will eventually do everything for you
auto()
{
    echo "Does nothing for now, returning to menu" && sleep 3 && start
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
	read -p "Enter choice [ 1 - 5] " choice
	case $choice in
		1) promptpasswd && sleep 1 && info ;;
		2) promptuname && sleep 1 && info ;;
        3) promptuname && promptpasswd && sleep 1 && info ;;
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
	read -p "Enter choice [ 1 - 5] " choice
	case $choice in
		1) checkrelease ;;
		2) checkrelease 1 ;;
        3) checkrelease && checkrelease 1 ;;
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
    elif
    then [ "$1" = "3" ]
        local uname
        local passwd
        passwd=$(head -n 1 password)
        uname=$(head -n 1 username)
        echo "Current info, username: $uname | password: $passwd"
        echo ""
    fi
    
    echo "1) Install dependencies"
    echo "2) Auto (not yet built)"
    echo "3) Set user info"
    echo "4) Remove blacklisted packages(under construction, needs to be run in full windows)"
    echo "5) Check release"
    echo "6) Exit"
}

#reads input for main menu
readmain(){
	local choice
	read -p "Enter choice [ 1 - 5] " choice
	case $choice in
		1) installdependencies && start 0 1 ;;
        2) auto ;;
		3) info ;;
        4) rmblacklist ;;
        5) release ;;
		6) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2 && start
	esac
}

#starts important functions(dependency installer and 
#initializes the main menu and the maim menu input reader)
start()
{
    if [ "$1" = "1" ]
    then
        installdependencies
    fi
    mainmenu "$2"
    readmain
}

#master function, everything branches from this call
start 1 2

#test functions:

#newterminal sudo ./rmblacklist.sh
#newterminal
#mainmenu
#readmain
#promptuname
#promptpasswd
#checkrelease
#checkrelease 1
#rmblacklist
