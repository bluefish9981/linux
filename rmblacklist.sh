#removes blacklisted packages
for pack in `cat blacklist`
do apt-get remove $pack -y #| grep "random bullshit"
echo "Uninstalling $pack  if found."
done
echo "Removal of blacklisted packages complete!"
xterm -e ./ufw.sh
sleep 60