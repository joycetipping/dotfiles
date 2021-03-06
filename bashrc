#!/bin/bash

# If not running interactively, don't do anything. This prevents these
# configurations from being loaded when bash is in scripting mode.
[[ $- != *i* ]] && return

# Adjust the path
[[ -d "$HOME/bin" ]] && PATH="$PATH:$HOME/bin"  # Include user's private bin

# Terminal settings
export EDITOR="/usr/bin/vim"
export VISUAL="/usr/bin/vim"
export TERM='xterm-256color'
export TZ='/usr/share/zoneinfo/America/Denver'  # Set time zone to MST
export GDK_SCALE=2  # Scale all gtk-3.0 applications for 4k monitor
export QT_SCALE_FACTOR=2

# Source Spencer's bash prompt
[[ -d ~/.bash ]] || git clone git@github.com:joycetipping/dotbash.git "$HOME/.bash"
source "$HOME/.bash/init"

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

alias common="cd /mnt/v1/common/"
alias jt="cd /mnt/v1/jt/"
alias kids="cd /mnt/v1/common/kids/"
alias v1="cd /mnt/v1/"

# Home
alias ev0="curl http://192.168.0.34:8180/0"  # turn evaporative off
alias evf="curl http://192.168.0.34:8180/4"  # turn evaporative to fan
alias evc="curl http://192.168.0.34:8180/5"  # turn evaporative to cool

# Date and time
alias d="date"
alias now="date '+%A %-d %B %Y %H:%M:%S %Z'"

# Other
alias baby="ssh iridium 'arecord -f cd -t wav' | play -t wav - compand .01,.01 -inf,-40,-inf,-40,-40 0 -90 .1"
alias bc="echo Starting bc -l;echo;bc -l"
alias grep="grep --color"
alias pd='rlwrap perl -de1'
alias pyserver='python -m SimpleHTTPServer 8080'
alias randsync='find -print0 -type f | shuf | head -n100 | xargs -0 -I{} rsync -aP {}'
alias sizes='du -sh | sort -h'
alias sus='sudo pm-suspend'

# }}}

# Functions {{{

audio () {
  #arecord -f cd -t raw | oggenc - -r -o ~/media/audio/arecord/`date +%Y.%m%d.%H%M%S`.ogg
  rec -r 48k -b 32 ~/media/audio/sox/`date +%Y.%m%d.%H%M%S`.ogg
}

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

randcopy () {
  number=$1
  shift
  destination=$1
  shift

  find -print0 -type f | shuf | head -n$number | xargs -0 -I{} rsync -aP {} $destination $@
}

howlong () {
  # Display the length of an audio file
  ffmpeg -i $1 2>&1 | grep Duration
}

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
export R_LIBS="$HOME/.R:$R_LIBS"


# Ruby
# ----
rubyserver () {
  port="${1:-3000}"
  ruby -run -e httpd . -p $port
}

# }}}

true
