#!/bin/sh

# Battery systray
#cbatticon -u 5 &

# Systray volume
pasystray &

# Spanish keyboard
setxkbmap -layout es,es -model latin1

# Image Compositor
picom &

# Wallpaper
feh --bg-scale ~/wallpapers/nvidia_loko.jpg

# Volume all up
pactl set-sink-volume @DEFAULT_SINK@ 100%
