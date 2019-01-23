#!/bin/bash
[ -z "$PS1" ] && return

hat_identity() { :; }
hat_observe()  { :; }

[[ -d ~/.bash ]] || git clone https://github.com/joycetipping/dotbash.git ~/.bash

export TZ='/usr/share/zoneinfo/America/Denver'

export TERM=rxvt-unicode

source ~/.bash/init

export GPG_TTY=`tty`


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

# Aliases {{{

# Source any machine-specific aliases if we have them
[[ -e ~/.bash_aliases ]] && source ~/.bash_aliases

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

# Places
alias blog="cd $HOME/projects/blog/"
alias diary="cd $HOME/projects/life/diary/"
alias dots="cd $HOME/projects/dotfiles/"
alias dreams="vim $HOME/projects/life/dreams/$(date '+%Y').txt"
alias fubar="cd $HOME/projects/company/"
alias journal="cd $HOME/projects/life/journal/"
alias notes="cd $HOME/projects/notes/"
alias projects="cd $HOME/projects/"
alias safe="cd $HOME/projects/safe/"
alias website="cd $HOME/projects/joycetipping.com/"

# Home
alias ev0="curl http://192.168.0.34:8180/0"  # turn evaporative off
alias evf="curl http://192.168.0.34:8180/4"  # turn evaporative to fan
alias evc="curl http://192.168.0.34:8180/5"  # turn evaporative to cool

# Date and time
alias d="date"
alias now="date '+%A %-d %B %Y %H:%M:%S %Z'"

# Other
#alias audio='arecord -f cd -t raw | oggenc - -r -o ~/media/audio/arecord/`date +%Y.%m%d.%H%M%S`.ogg'
alias audio='rec −r 44100 −b 32 −e signed-integer ~/media/audio/sox/`date +%Y.%m%d.%H%M%S`.ogg'
alias bc="echo Starting bc -l;echo;bc -l"
alias grep="grep --color"
alias pd='rlwrap perl -de1'
alias pyserver='python -m SimpleHTTPServer 8080'
alias sizes='du -sh | sort -h'
alias sus='sudo pm-suspend'

# }}}

# Programs {{{

# BC
# --
export BC_ENV_ARGS="$HOME/.bcrc"


# Exiftool
# --------
dates () {
  # Print all EXIF date fields
  for var in "$@";
  do
    echo "$var"
    exiftool "$var" | grep -i 'date'
    echo
  done
}


# R
# -
export R_LIBS="$home/.R:$R_LIBS"


# Ruby
# ----
rubyserver () {
  port="${1:-3000}"
  ruby -run -e httpd . -p $port
}


# Miscellaneous
# -------------
count () {
  # Count the number of files in the given directories
  if [[ "$#" == "0" ]]
  then
    ls | wc -l
  else
    for var in "$@";
    do
      ls "$var" | wc -l
    done
  fi
}

csum () {
  # Sum the number of files in the given directories
  count "$@" | awk '{s+=$1} END {print s}'
}

# }}}

true
