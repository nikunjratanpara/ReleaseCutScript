# hotfix-deploy-proccess
set -e

git status

read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
echo "Continued...."

git checkout develop
git pull

git checkout main
git pull

read -p "Release version (v5.xxx.x) : " version 

git checkout hotfix/$version
git pull origin hotfix/$version

git flow hotfix finish $version
