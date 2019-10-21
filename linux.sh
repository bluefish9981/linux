rmblacklist()
{
    for pack in `cat blacklist`
    do apt-get remove $pack -y | grep "random bullshit"
    echo "Uninstalling $pack  if found."
    done
}

checkrelease() #still needs adjustments
{
    FILE1=/etc/os-release
    FILE2=/etc/lsb-release
    if test -f "$FILE1"
    then
        if [$1 -eq 1]
        then
            cat $FILE1 > ~/Desktop/release_info
        else
            cat $FILE1
        fi
    elif test -f "$FILE2"
    then
        if [$1 -eq 1]
        then
            cat $FILE2 > ~/Desktop/release_info
        else
            cat $FILE2
        fi
    else
        echo "Release infor not found"
    fi
}
#checkrelease
rmblacklist