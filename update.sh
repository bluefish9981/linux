echo "Updating..."
sudo apt-get -y update | grep "random bullshit"
echo "Done"
echo ""
echo "Update done, upgrading(and full-upgrade) now..."
sudo apt-get -y upgrade | grep "random bullshit"
sudo apt-get -y full-upgrade | grep "random bullshit"
echo ""
echo "Complete!"
if [ "$1" = "1" ]
then
xterm -e ./rmblacklist.sh
fi
sleep 60