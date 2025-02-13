set -e

git status

echo "You must be on develop branch to continue if not exit from script." 
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
echo "Continued...."

read -p "Going to push develop and main branch along with new tag,Do you want to continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

git checkout main 
git push

git checkout develop
git pull
read -p "Next Develop version (5.xxx.x-SNAPSHOT) : " nextVersion 
mvn versions:set -DnewVersion=$nextVersion
git status
git diff
mvn versions:commit
git status
git diff

read -p "going to commit & push pom.xml changes in current branch,Do you want to continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
git add pom.xml
git status
git commit -m "Updating Develop Version"
git push


git push --tags