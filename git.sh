echo "Sourcing git helpers..."

# Functions
git-local() {
  git branch -vv | cut -c 3- | awk '$3 !~/\[/ { print $1 }'
}

git-newbranch() {
  git stash save
  git fetch origin
  git checkout -b $1
  git reset --hard origin/master
}

git-commit() {
  git add -A
  git commit -a -m "$1" --no-edit
}

git-push() {
  git push -u origin $(git branch | sed -n '/\* /s///p')
}

git-pushf() {
  git push -f -u origin $(git branch | sed -n '/\* /s///p')
}

# Aliases
alias git-amend='git commit -a --amend --no-edit'
alias git-afp='git-amend && git-pushf'
alias git-pullr='git pull origin master --rebase'
alias git-delete-merged='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
