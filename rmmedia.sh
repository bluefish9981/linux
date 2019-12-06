#removes media files
echo "Deleting media files, please wait..."
currentdir=$(pwd)
for ext in `cat extensions`
do
cd
cd ..
sudo find . -type f -name "*.$ext" -delete
echo "Removing encountered $ext files"
cd "$currentdir"
done
echo "Removal of unwanted media complete!"
sleep 60
