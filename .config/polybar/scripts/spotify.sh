#!/bin/bash
status=$(playerctl --player=spotify status 2>/dev/null)

if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
    artist=$(playerctl --player=spotify metadata artist 2>/dev/null)
    title=$(playerctl --player=spotify metadata title 2>/dev/null)

    track="$artist - $title"
    if [[ ${#track} -gt 35 ]]; then
        track="${track:0:35}..."
    fi

    if [[ "$status" == "Playing" ]]; then
        play_icon="󰏤"
    else
        play_icon="󰐊"
    fi

    echo "%{B#A6E3A1}%{F#24273A} 󰒮  $play_icon  󰒭 %{B#363A4F}%{F#CAD3F5}  $track %{B-}%{F-}"
else
    echo ""
fi
