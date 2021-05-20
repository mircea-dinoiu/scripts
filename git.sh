echo "Sourcing git helpers..."

git config --global --replace-all alias.co checkout
git config --global --replace-all alias.s status
git config --global --replace-all alias.amend "commit --amend --no-edit"
git config --global --replace-all alias.sync "pull origin master"
git config --global --replace-all alias.pick "cherry-pick"
git config --global --replace-all alias.p "push -u origin HEAD"
git config --global --replace-all alias.pf "push -f origin HEAD"
git config --global --replace-all alias.lb "for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

# Functions
gitlocal() {
  git branch -vv | cut -c 3- | awk '$3 !~/\[/ { print $1 }'
}

gitnew() {
  git fetch origin
  git checkout -B $1
  git reset --hard origin/master
}

gitnewx() {
  git branch -D $1
  gitnew $1
}

gitc() {
  git add -A
  git commit -a -m "$1" --no-edit
}

gitp() {
  echo "Deprecation Warning: use <git p> instead"
  git push -u origin $(git branch | sed -n '/\* /s///p')
}

gitpf() {
  echo "Deprecation Warning: use <git pf> instead"
  git push -f -u origin $(git branch | sed -n '/\* /s///p')
}

git-cleanup() {
  git fetch --prune
  git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' |  xargs git branch -d -f
  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

gitnotpushed() {
  git branch -vv --sort=-committerdate | cut -c 3- | awk '$3 !~/\[/ { print $1 }'
}

gitdel() {
  git branch -D "$@"
}

gitcp() {
  gitc "$1"
  gitp
}

gitwip() {
  gitcp "Stopping point"
}

gitamendp() {
  git add -A
  git commit -a --amend --no-edit
  gitpf
}
