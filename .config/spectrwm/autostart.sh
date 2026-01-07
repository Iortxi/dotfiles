#!/bin/bash

# Spectrwm autostart script

# Battery systray
#cbatticon -u 5 &


# Target e IP vacios
echo -n "No IP" > ~/.config/spectrwm/ipBD
echo -n "No target" > ~/.config/spectrwm/objetivoBD


# Fondo de pantalla
feh --bg-scale ~/wallpapers/nvidia_loko.jpg


# Teclado en español
setxkbmap es,es


# Volume all up
pactl set-sink-volume @DEFAULT_SINK@ 100%


# Compositor de imagenes
picom &

trayer                 \
    --monitor primary  \
    --edge top         \
    --widthtype pixel  \
    --width 100        \
    --heighttype pixel \
    --height 18        \
    --align right      \
    --margin 455       \
    --transparent true \
    --alpha 0          \
    --tint 0x0F101A    \
    --iconspacing 3    \
    --distance 1 &
