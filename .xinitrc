#!/bin/sh

# exec gnome-session
# exec startkde
# exec startxfce4
# exec .xsession

xmonad & wmpid=$!
urxvtd -f -o &
xscreensaver -nosplash &
/home/prvak/bin/change-wallpaper not_a_computer.png &
/home/prvak/bin/xosdutil &
setxkbmap -option grp:switch,grp:alt_shift_toggle,compose:caps us,cz -variant ,qwerty &
xrdb -merge ~/.Xresources

wait $wmpid
