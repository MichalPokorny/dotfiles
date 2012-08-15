#!/bin/bash
export SAL_USE_VCLPLUGIN=gen
export MOZ_DISABLE_PANGO=1
urxvtd -f -o &
xscreensaver -nosplash &
/home/prvak/bin/change_wallpaper not_a_computer.png &
/home/prvak/bin/xosdutil &
setxkbmap -option grp:switch,grp:alt_shift_toggle,compose:caps us,cz -variant ,qwerty &
xrdb -merge ~/.Xresources
exec xmonad
#exec awesome
