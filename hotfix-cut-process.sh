set -e
git status
# Take User Input 
# Exit if git changes are not clear 
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

echo "Continued..."

git checkout develop
git pull

git checkout main
git pull

read -p "hotfix version : " version 
echo $version
read -p "hotfix version $version, Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
echo "hotfix start $version"

git flow hotfix start $version

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

git push origin hotfix/$version

echo "Create a pull request from the hotfix branch to main on Github, label it as "hotfix" and add relevant reviewers."
