#!/bin/bash
source git.sh
source git_branch_in_prompt.sh

echo "Sourcing bash profile..."

wds() {
  killwds
  npm run webpack:server
}

pngtojpg() {
  sips -s format jpeg $1.png --out $1.jpg
  rm $1.png
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

# Other aliases
alias httpserver='http-server -S -p 3000 public'
alias addDockSep='defaults write com.apple.dock persistent-apps -array-add '"'"'{ "tile-type" = "spacer-tile"; }'"'"'; killall Dock'

# Bash completion
if iscmd brew; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

export PATH="$HOME/.yarn/bin:$PATH"
