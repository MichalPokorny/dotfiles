#!/bin/sh

eval $(gpg-agent --daemon)
xmonad & wmpid=$!
xscreensaver -nosplash &

xosdutil &
xrdb -merge ~/.Xresources
/usr/lib/notification-daemon-*/notification-daemon &
setxkbmap -option grp:switch,grp:alt_shift_toggle,compose:caps us,cz -variant ,qwerty
xmodmap ~/.Xmodmap
xset +fp /usr/share/fonts/local/
xset fp rehash

# redshift -l 50:14 &  # Prague
redshift -l 37:-122 &  # San Francisco

xdg-user-dirs-update &
wmname LG3D & # Make Java GUIs work

start-pulseaudio-x11

wait $wmpid
