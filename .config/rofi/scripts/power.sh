#!/bin/bash

declare -A options
options=(
    ["󰐥 Shutdown"]="systemctl poweroff"
    ["󰜉 Reboot"]="systemctl reboot"
    ["󰌾 Lock"]="i3lock -c 24273A"
    ["󰗽 Logout"]="i3-msg exit"
    ["󰒲 Suspend"]="systemctl suspend"
)

# Print options for rofi
if [[ "$@" == "" ]]; then
    for key in "${!options[@]}"; do
        echo "$key"
    done
    exit 0
fi

# Execute selected option
${options["$@"]}
