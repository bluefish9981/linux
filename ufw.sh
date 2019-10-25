echo "Making sure ufw(firewall) is installed..."
sudo apt-get install ufw -y | grep "random bullshit"
echo "Enabling firewall."
ufw enable | grep "random bullshit"
echo "Done!"
sleep 60