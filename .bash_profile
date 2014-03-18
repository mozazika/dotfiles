#! /bin/bash

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# handy !
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# toggle wifi on/off using command line
function togglewifi() {
  local wifindx=-1
  local count=0
  while read -r line; do
    if [ "$line" == "Wi-Fi" ]
    then
      # count - 1 in order to ingnore the first line
      # of the command output
      wifindx=`expr $count - 1`
    fi
    (( count++ ))
  done < <(networksetup -listallnetworkservices)

  local wifstatus="$(networksetup -getairportpower en$wifindx)"
  if [ "$wifstatus" == "Wi-Fi Power (en$wifindx): Off" ]
  then
    networksetup -setairportpower en$wifindx on
    echo "starting wifi..."
  else
    networksetup -setairportpower en$wifindx off
    echo "stopping wifi..."
  fi
}

alias resource='source ~/.bash_profile'

function editconflicts() {
  mvim  $(git diff --name-only --diff-filter=U | xargs)
}
alias sonas='bash ~/sonas.sh'

alias tmus='tmux'

alias ls='ls -lhaG'
alias ll='ls -l'

# up 'n' folders
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias nbi='npm install && bower install'

# git commamands simplified
alias gst='git status -sb'
alias gad='git add -A .'
alias gco='git checkout'
alias gci='git commit -am'
alias gps='git push origin'
alias gpl='git pull origin'
alias grb='git rebase'
alias gbr='git branch'
alias glg='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'
alias glg2='git log --date-order --all --graph --name-status --format="%C(green)%H%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'

alias mongostart='launchctl start org.mongodb.mongod'
alias mongostop='launchctl stop org.mongodb.mongod'

export NODE_PATH="/usr/local/lib/node"
export PATH="/usr/local/bin:$PATH"
set -o vi

# lock computer
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export NODE_PATH=/usr/local/lib/node:/usr/local/lib/node_modules

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

source ~/.bash_prompt
