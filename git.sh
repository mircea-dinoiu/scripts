echo "Sourcing git helpers..."

git config --global --replace-all alias.co checkout
git config --global --replace-all alias.s status
git config --global --replace-all alias.ca "commit --amend --no-edit"
git config --global --replace-all alias.pm "pull origin master"
git config --global --replace-all alias.pmr "pull origin master --rebase"

# Functions
git-local() {
  git branch -vv | cut -c 3- | awk '$3 !~/\[/ { print $1 }'
}

git-newbranch() {
  git fetch origin
  git checkout -B $1
  git reset --hard origin/master
}

git-ce() {
  git add -A
  git commit -a -m "$1" --no-edit
}

git-push() {
  git push -u origin $(git branch | sed -n '/\* /s///p')
}

git-pushf() {
  git push -f -u origin $(git branch | sed -n '/\* /s///p')
}

git-deletelocal() {
  git fetch --prune
  git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' |  xargs git branch -d -f
}

git-notpushed() {
  git branch -vv | cut -c 3- | awk '$3 !~/\[/ { print $1 }'
}

git-cep() {
  git add -A
  git commit -a -m "$1" --no-edit
  git-push
}

# Aliases
alias git-ca='git commit -a --amend --no-edit'
alias git-afp='git-ca && git-pushf'
alias git-pullr='git pull origin master --rebase'
alias git-pushall='git push --all'
alias git-deletemerged='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'