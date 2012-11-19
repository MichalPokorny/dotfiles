#!/bin/bash
export SAL_USE_VCLPLUGIN=gen
export MOZ_DISABLE_PANGO=1
urxvtd &
xscreensaver -nosplash &
/home/prvak/bin/change_wallpaper &
/home/prvak/bin/xosdutil &
setxkbmap -option grp:switch,grp:alt_shift_toggle us,cz -variant ,qwerty &
exec xmonad
#exec awesome
