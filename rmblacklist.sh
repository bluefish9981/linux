
    #removes blacklisted packages
    for pack in `cat blacklist`
    do apt-get remove $pack -y #| grep "random bullshit"
    echo "Uninstalling $pack  if found."
    done