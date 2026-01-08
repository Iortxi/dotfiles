#!/bin/sh

# Battery systray
#cbatticon -u 5 &

# Systray volume
pasystray &

# Spanish keyboard
setxkbmap -layout es,es

# Image Compositor
picom &

# Wallpaper
feh --bg-fill ~/wallpapers/nvidia.jpg

# Volume all up
pactl set-sink-volume @DEFAULT_SINK@ 100%
