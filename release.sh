username=$(head -n 1 username)
FILE1=/etc/os-release
FILE2=/etc/lsb-release
echo "Release info: "
echo ""
if test -f "$FILE1"
    then
        cat cat $FILE1
        cat $FILE1 > /home/$username/Desktop/release_info
        echo ""
        echo "Saving to /home/$username/Desktop/release_info"
elif test -f "$FILE2"
    then
        cat $FILE2
        cat $FILE2 > /home/$username/Desktop/release_info
        echo ""
        echo "Saving to /home/$username/Desktop/release_info"
else
    echo "Release info not found"
fi
echo ""
echo "Done!"
sleep 60