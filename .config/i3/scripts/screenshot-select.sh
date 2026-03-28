#!/bin/bash
pkill picom
sleep 0.3
maim -s | xclip -selection clipboard -t image/png
notify-send 'Screenshot' 'Copied to clipboard'
picom --config ~/.config/picom/picom.conf -b &
