#!/bin/sh

eval $(gpg-agent --daemon)
xmonad & wmpid=$!
urxvtd -f -o &
xscreensaver -nosplash &
xosdutil &
setxkbmap -option grp:switch,grp:alt_shift_toggle,compose:caps us,cz -variant ,qwerty &
xrdb -merge ~/.Xresources

wait $wmpid

