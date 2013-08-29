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
redshift -l 50:14 &
xdg-user-dirs-update &

wait $wmpid

