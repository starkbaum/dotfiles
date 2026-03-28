#!/bin/bash
status=$(playerctl --player=spotify status 2>/dev/null)

if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
    artist=$(playerctl --player=spotify metadata artist 2>/dev/null)
    title=$(playerctl --player=spotify metadata title 2>/dev/null)
    position=$(playerctl --player=spotify position 2>/dev/null)
    length=$(playerctl --player=spotify metadata mpris:length 2>/dev/null)

    track="$artist - $title"
    if [[ ${#track} -gt 30 ]]; then
        track="${track:0:30}..."
    fi

    # Convert position to seconds and length from microseconds
    pos_sec=$(echo "$position" | cut -d. -f1)
    len_sec=$(( length / 1000000 ))

    # Build progress bar
    bar_width=10
    if [[ $len_sec -gt 0 ]]; then
        filled=$(( pos_sec * bar_width / len_sec ))
    else
        filled=0
    fi
    empty=$(( bar_width - filled ))
    bar=""
    for ((i=0; i<filled; i++)); do bar+="─"; done
    bar+="●"
    for ((i=0; i<empty; i++)); do bar+="─"; done

    # Format time
    pos_fmt=$(printf "%d:%02d" $((pos_sec/60)) $((pos_sec%60)))
    len_fmt=$(printf "%d:%02d" $((len_sec/60)) $((len_sec%60)))

    if [[ "$status" == "Playing" ]]; then
        play_icon="󰏤"
    else
        play_icon="󰐊"
    fi

    echo "%{B#A6E3A1}%{F#24273A} 󰒮  $play_icon  󰒭 %{B#363A4F}%{F#CAD3F5}  $track  %{F#A6E3A1}$bar%{F#CAD3F5}  $pos_fmt/$len_fmt %{B-}%{F-}"
else
    echo ""
fi
