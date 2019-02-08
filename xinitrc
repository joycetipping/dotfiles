#!/bin/sh
openbox &
wm_pid=$!

init_session() {
  xset r rate 300 60
  setlayout 0 10 10 0
  synclient VertEdgeScroll=0 \
            VertTwoFingerScroll=1 \
            HorizTwoFingerScroll=1 \
            VertScrollDelta=-114 \
            HorizScrollDelta=-114 \
            RTCornerButton=0 \
            RBCornerButton=0 \
            RightButtonAreaLeft=0 \
            RightButtonAreaTop=0 \
            PalmDetect=1 \
            PalmMinWidth=5 \
            PalmMinZ=100 \
            FingerHigh=45 \
            FingerLow=35 \
            MaxTapTime=0
  xrdb ~/.Xresources
  xmodmap ~/.Xmodmap
  xcompmgr &
  conky &
  pulseaudio --start
  feh --bg-fill ~/projects/dotfiles/backgrounds/handwriting.jpg
}

sleep 2 && init_session

wait $wm_pid
