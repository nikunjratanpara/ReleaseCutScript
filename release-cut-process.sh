set -e
git status

# Take User Input 
# Exit if git changes are not clear 
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
echo "Continued...."
#Checkout main branch and pull latest
git checkout main 
git pull

#Checkout develop branch and pull latest
git checkout develop
git pull

# Check for any concern on dev channel 
read -p "Check for any concern on dev channel, Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

read -p "Release version (v5.xxx.x): " version 
echo $version
read -p "release version $version, Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
echo "release start $version"

git flow release start $version

echo "Changing pom version for release"
ver="${version//v/}"

mvn versions:set -DnewVersion=$ver
git status
git diff

mvn versions:commit
git status
git diff

git add pom.xml
git status
git commit -m "Updating Develop Version"

git push origin release/$version


