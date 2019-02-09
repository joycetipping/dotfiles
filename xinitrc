#!/bin/sh
openbox &
wm_pid=$!

init_session() {
  xset r rate 300 60
  setlayout 0 10 10 0
  xinput set-prop 13 'libinput Tapping Enabled' 1
  xinput set-prop 13 'libinput Tapping Drag Enabled' 1
  xinput set-prop 13 'libinput Natural Scrolling Enabled' 1
  xinput set-prop 13 'libinput Middle Emulation Enabled' 1
  xinput set-prop 13 'libinput Accel Speed' 1.0
  xinput set-prop 13 'libinput Horizontal Scroll Enabled' 1
  xrdb ~/.Xresources
  xmodmap ~/.Xmodmap
  xcompmgr &
  conky &
  pulseaudio --start
  feh --bg-fill ~/projects/dotfiles/backgrounds/handwriting.jpg
}

sleep 2 && init_session

wait $wm_pid
