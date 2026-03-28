#!/bin/bash

# Get player status
status=$(playerctl --player=spotify status 2>/dev/null)

if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
    artist=$(playerctl --player=spotify metadata artist 2>/dev/null)
    title=$(playerctl --player=spotify metadata title 2>/dev/null)
    
    # Truncate if too long
    max=40
    track="$artist - $title"
    if [[ ${#track} -gt $max ]]; then
        track="${track:0:$max}..."
    fi
    
    if [[ "$status" == "Playing" ]]; then
        echo "󰎆 $track"
    else
        echo "󰏤 $track"
    fi
else
    echo ""
fi
