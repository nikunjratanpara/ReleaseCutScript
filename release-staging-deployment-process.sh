set -e
#release-staging-deployment-process
git status

read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
echo "Continued...."

git checkout develop
git pull

git checkout main
git pull

read -p "Release version (v5.xxx.x) : " version 

read -p "Finishing release version $version,Do you want to continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

git checkout release/$version
git pull

git flow release finish $version

read -p "Going to push develop and main branch along with new tag,Do you want to continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

git status

git checkout main
git push

git checkout develop
git pull

mvn versions:set
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
