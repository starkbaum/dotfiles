#!/bin/bash
status=$(playerctl --player=spotify status 2>/dev/null)

if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
    position=$(playerctl --player=spotify position 2>/dev/null)
    length=$(playerctl --player=spotify metadata mpris:length 2>/dev/null)

    pos_sec=$(echo "$position" | cut -d. -f1)
    len_sec=$(( length / 1000000 ))

    bar_width=50
    if [[ $len_sec -gt 0 ]]; then
        filled=$(( pos_sec * bar_width / len_sec ))
    else
        filled=0
    fi
    empty=$(( bar_width - filled ))

    bar=""
    bar="%{F#A6E3A1}"
    for ((i=0; i<filled; i++)); do bar+="─"; done
    bar+="%{F#363A4F}"
    for ((i=0; i<empty; i++)); do bar+="─"; done
    bar+="%{F-}"
    echo "$bar"
else
    echo ""
fi
