#!/bin/sh

eval $(gpg-agent --daemon)
xmonad & wmpid=$!
xscreensaver -nosplash &

# https://bbs.archlinux.org/viewtopic.php?id=202952
dbus-update-activation-environment --all &

xosdutil &
xrdb -merge ~/.Xresources &
/usr/lib/notification-daemon-*/notification-daemon &

# Use fonts from /usr/share/fonts/local/.
xset +fp /usr/share/fonts/local/
xset fp rehash

keyboard-setup

redshift -l 50:14 -m randr &  # Prague
# redshift -l 37:-122 &  # San Francisco

# Dropbox
## disabled because of upload limit
##dropbox &

xdg-user-dirs-update &
wmname LG3D & # Make Java GUIs work

start-pulseaudio-x11 &
stalonetray &!
nm-applet &!
rescuetime &!
skype &!

wait $wmpid
