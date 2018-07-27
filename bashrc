#!/bin/bash
[ -z "$PS1" ] && return

hat_identity() { :; }
hat_observe()  { :; }

[[ -d ~/.bash ]] || git clone git@github.com:joycetipping/dotbash.git ~/.bash

source ~/.bash/init

export GPG_TTY=`tty`

# Source any machine-specific aliases if we have them
[[ -e ~/.bash_aliases ]] && source ~/.bash_aliases

# Aliases {{{

# Navigation
alias l='ls -CF'
alias la="ls -a"
alias ll="ls -ilh"
alias ls="ls --color=auto"
alias s="ls"
alias u="cd ../"
alias u2="cd ../../"
alias u3="cd ../../../"
alias u4="cd ../../../../"
alias u5="cd ../../../../../"
alias u6="cd ../../../../../../"
alias u7="cd ../../../../../../../"
alias u8="cd ../../../../../../../../"

# Home
alias ev0="curl http://192.168.0.34:8180/0"  # turn evaporative off
alias evf="curl http://192.168.0.34:8180/4"  # turn evaporative to fan
alias evc="curl http://192.168.0.34:8180/5"  # turn evaporative to cool

# Other
alias bc="echo Starting bc -l;echo;bc -l"
alias grep="grep --color"
alias now="date +%Y.%m%d.%H%M"
alias pd='rlwrap perl -de1'

# }}}


# If we don't have a DISPLAY already, set it to :0
# (in practice this happens if you don't have bashrc-xpra and you're sshing
# somewhere without -X)
export DISPLAY=${DISPLAY:-:0}

shopt -s checkwinsize extglob

umask 022

export NODE_PATH="$HOME/.node:$NODE_PATH"

# Environment variables
export VISUAL="/usr/bin/vim"
export EDITOR=$VISUAL
export PS1='\[\033[1;32m\]\h\[\033[1;30m\]\W\[\033[0;0m\] '

# ni configuration
export NI_ROW_SORT_BUFFER=1024M
export NI_ROW_SORT_COMPRESS=gzip
export NI_ROW_SORT_PARALLEL=`cat /proc/cpuinfo | grep vendor_id | wc -l`

export GNUTERM=wxt

export LC_ALL=${LC_ALL:-C.UTF-8}

if [[ $TERM == 'xterm' ]]; then
  export TERM='xterm-color'
fi

if test -e ~/.dir_colors && which dircolors >& /dev/null; then
  eval $(dircolors ~/.dir_colors)
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

[[ $PWD == $HOME && -d $HOME/r ]] && cd $HOME/r

true
