#!/bin/bash

promptuname()
{
    echo -n "Enter the username and press [ENTER]: "
    read uname
    echo $uname > username
}

promptpasswd()
{
    echo "Enter the password (matching previously"
    echo -n "entered user) and press [ENTER]: "
    read -s passwd
    echo $passwd > password
}

rmblacklist()
{
    for pack in `cat blacklist`
    do apt-get remove $pack -y | grep "random bullshit"
    echo "Uninstalling $pack  if found."
    done
}

checkrelease() #still needs adjustments
{
    username=$(head -n 1 username)
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
        echo "Release infor not found"
    fi
}

menu()
{
    clear
    echo "   ____      _               ____  _             _   
  / ___|   _| |__   ___ _ __| __ )| |_   _  __ _| |_ 
 | |  | | | | '_ \ / _ \ '__|  _ \| | | | |/ _\` | __|
 | |__| |_| | |_) |  __/ |  | |_) | | |_| | (_| | |_ 
  \____\__, |_.__/ \___|_|  |____/|_|\__, |\__,_|\__|
       |___/                         |___/           "
}
menu
#promptuname
#promptpasswd
#checkrelease
#checkrelease 1
#rmblacklist