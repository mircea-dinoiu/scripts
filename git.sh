echo "Sourcing git helpers..."

git config --global --replace-all alias.co checkout
git config --global --replace-all alias.s status
git config --global --replace-all alias.amend "commit --amend --no-edit"
git config --global --replace-all alias.pm "pull origin master"
git config --global --replace-all alias.pmr "pull origin master --rebase"

# Functions
gitlocal() {
  git branch -vv | cut -c 3- | awk '$3 !~/\[/ { print $1 }'
}

gitnewbranch() {
  git fetch origin
  git checkout -B $1
  git reset --hard origin/master
}

gitca() {
  git add -A
  git commit -a -m "$1" --no-edit
}

gitp() {
  git push -u origin $(git branch | sed -n '/\* /s///p')
}

gitpf() {
  git push -f -u origin $(git branch | sed -n '/\* /s///p')
}

gitdeletelocal() {
  git fetch --prune
  git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' |  xargs git branch -d -f
}

gitnotpushed() {
  git branch -vv --sort=-committerdate | cut -c 3- | awk '$3 !~/\[/ { print $1 }'
}

gitlb() {
  git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
}

gitdel() {
  git branch -D "$1"
}

gitcp() {
  git add -A
  git commit -a -m "$1" --no-edit
  gitp
}

gitcapf() {
  gitca $1
  git pf
}

# Aliases
alias gitpullr='git pull origin master --rebase'
alias gitpushall='git push --all'
alias gitdeletemerged='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'