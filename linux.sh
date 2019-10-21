#!/bin/bash
RED='\033[0;41;30m'
STD='\033[0;0;39m'

promptuname()
{
    echo -n "Enter the username and press [ENTER]: "
    read uname
    echo $uname > username
}

promptpasswd()
{
    echo "Enter the password (matching "
    echo -n "user) and press [ENTER]: "
    read -s passwd
    echo $passwd > password
}

displayuserinfo()
{
    local uname
    local passwd
    passwd=$(head -n 1 password)
    uname=$(head -n 1 username)
    echo "Current info, username: $uname | password: $passwd"
    echo ""
}

newterminal()
{
    local FILE1
    local FILE2
    FILE1=/etc/os-release
    FILE2=/etc/lsb-release
    if test -f "$FILE1"
    then
        echo "Debian" && sleep 1
    elif test -f "$FILE2"
    then
        echo "Ubuntu" && sleep 1
    else
        echo "OS not found, defaulting Ubuntu" && sleep 2
    fi
    #for pack in `cat blacklist`
    #do apt-get remove $pack -y | grep "random bullshit"
    #echo "Uninstalling $pack  if found."
    #done
}

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

auto()
{
    echo "Does nothing for now, returning to menu" && sleep 3 && start
}

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

readinfo()
{
    local choice
	read -p "Enter choice [ 1 - 5] " choice
	case $choice in
		1) promptpasswd && sleep 1 && info ;;
		2) promptuname && sleep 1 && info ;;
        3) promptuname && promptpasswd && sleep 1 && info ;;
        4) start ;;
		5) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2 && info
	esac
}

info()
{
    infomenu
    readinfo
}

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

release()
{
    releasemenu
    readrelease
}

mainmenu()
{
    clear
    banner
    echo "1) Auto (not yet built)"
    echo "2) Set user info"
    echo "3) Remove blacklisted packages"
    echo "4) Check release"
    echo "5) Exit"
}

readmain(){
	local choice
	read -p "Enter choice [ 1 - 5] " choice
	case $choice in
		1) auto ;;
		2) info ;;
        3) rmblacklist ;;
        4) release ;;
		5) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2 && start
	esac
}

start()
{
    mainmenu
    readmain
}

start
#newterminal
#mainmenu
#readmain
#promptuname
#promptpasswd
#checkrelease
#checkrelease 1
#rmblacklist