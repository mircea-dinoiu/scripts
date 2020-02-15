#!/bin/bash
source git.sh
source git_branch_in_prompt.sh

echo "Sourcing bash profile..."

_wds() {
  killwds
  yarn webpack:server
}

removeEmptyDirs() {
  find . -type d -empty | xargs rmdir
}

wds() {
  while sleep 1; do _wds; done
}

reload() {
  if [ "$(uname)" == "Darwin" ]; then
    source ~/.bash_profile
  else
    source ~/.profile
  fi
}

code () {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        open -a "Visual Studio Code" --args "$F"
    fi
}

pngtojpg() {
  sips -s format jpeg $1.png --out $1.jpg
  rm $1.png
}

heictojpg() {
  magick mogrify -monitor -format jpg *.HEIC
}

tcp() {
  lsof -i tcp:$1
}

killport() {
  x=`lsof -Fp -i:$1`
  kill -9 ${x##p}
}

killwds() {
  ps aux | grep webpack | awk '{print $2}' | xargs kill -9
}

list_extensions() {
  find . -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u
}

iscmd()
{
  command -v "$1" >/dev/null 2>&1
}

repo()
{
  cd ~/repos/$1
}

sizegz() {
  wget -S -O "__tmp_size_gz__" --header="accept-encoding: gzip" $1
  rm "__tmp_size_gz__"
}

# Other aliases
alias httpserver='http-server -S -p 3000 public'
alias addDockSep='defaults write com.apple.dock persistent-apps -array-add '"'"'{ "tile-type" = "spacer-tile"; }'"'"'; killall Dock'

# Bash completion
if iscmd brew; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

export NODE_OPTIONS=--max_old_space_size=4096
export PATH="$HOME/.yarn/bin:$PATH"
