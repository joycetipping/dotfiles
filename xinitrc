#!/bin/sh
openbox &
wm_pid=$!

init_session() {
  xset r rate 150 60
  setlayout 0 10 10 0
  synclient VertEdgeScroll=0 \
            VertTwoFingerScroll=1 \
            HorizTwoFingerScroll=1 \
            RTCornerButton=0 \
            RBCornerButton=0 \
            PalmDetect=1 \
            PalmMinWidth=5 \
            PalmMinZ=100 \
            FingerLow=40 \
            FingerHigh=50 \
            VertScrollDelta=-114 \
            HorizScrollDelta=-114
  xrdb ~/.Xresources
  xcompmgr &
  pulseaudio --start
  nitrogen --set-zoom-fill ~/jbn8I.jpg
}

sleep 2 && init_session

wait $wm_pid
