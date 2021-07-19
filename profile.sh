#!/bin/bash
source nvm.sh
source docker.sh
source git.sh
source git_branch_in_prompt.sh

echo "Sourcing profile..."

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
  if [ -n "$ZSH_VERSION" ]; then
    source ~/.zprofile
    source ~/.zshrc
  elif [ -n "$BASH_VERSION" ]; then
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

curl_time() {
    curl -so /dev/null -w "\
   namelookup:  %{time_namelookup}s\n\
      connect:  %{time_connect}s\n\
   appconnect:  %{time_appconnect}s\n\
  pretransfer:  %{time_pretransfer}s\n\
     redirect:  %{time_redirect}s\n\
starttransfer:  %{time_starttransfer}s\n\
-------------------------\n\
        total:  %{time_total}s\n" "$@"
}

sizegz() {
  wget -S -O "__tmp_size_gz__" --header="accept-encoding: gzip" $1
  rm "__tmp_size_gz__"
}

# Other aliases
alias httpserver='http-server -S -p 3000 public'
alias addDockSep='defaults write com.apple.dock persistent-apps -array-add '"'"'{ "tile-type" = "spacer-tile"; }'"'"'; killall Dock'

# Shell completion
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

export NODE_OPTIONS=--max_old_space_size=4096
export PATH="$HOME/.yarn/bin:$PATH"
