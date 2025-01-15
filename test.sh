read -p "Release version : " version 
echo $version
ver="${version//v/}"

echo $ver