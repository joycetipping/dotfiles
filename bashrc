#!/bin/bash

# If not running interactively, don't do anything. This prevents these
# configurations from being loaded when bash is in scripting mode.
[[ $- != *i* ]] && return

# Adjust the path
[[ -d "$home/bin" ]] && PATH="$PATH:$home/bin"  # Include user's private bin

# Terminal settings
export EDITOR="/usr/bin/vim"
export VISUAL="/usr/bin/vim"
export TERM='xterm-256color'
export TZ='/usr/share/zoneinfo/America/Denver'  # Set time zone to MST
export GDK_SCALE=2  # Scale all gtk-3.0 applications for 4k monitor

# Source Spencer's bash prompt
[[ -d ~/.bash ]] || git clone git@github.com:joycetipping/dotbash.git "$home/.bash"
source "$home/.bash/init"

if test -e ~/.dir_colors && which dircolors >& /dev/null; then
  eval $(dircolors ~/.dir_colors)


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
alias audio="rec -r 48k -b 32 ~/media/audio/sox/`date +%Y.%m%d.%H%M%S`.ogg"
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
