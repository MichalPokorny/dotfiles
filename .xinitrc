#!/bin/sh

eval $(gpg-agent --daemon)
xmonad & wmpid=$!
urxvtd -f -o &
xscreensaver -nosplash &
/home/prvak/bin/change-wallpaper not_a_computer.png &
xosdutil &
setxkbmap -option grp:switch,grp:alt_shift_toggle,compose:caps us,cz -variant ,qwerty &
xrdb -merge ~/.Xresources

wait $wmpid
