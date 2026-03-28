#!/bin/bash
WALL="$HOME/Pictures/wallpaper"
# Pick a random wallpaper or fall back to first found
feh --bg-scale "$(find $WALL -type f -not -name ".*" | shuf -n 1)"
