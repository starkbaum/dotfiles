#!/bin/bash

# Get active ethernet interface
eth=$(ip link show | grep -E "^[0-9]" | awk '{print $2}' | tr -d ':' | grep -E "^e" | head -1)
# Get active wifi interface  
wifi=$(ip link show | grep -E "^[0-9]" | awk '{print $2}' | tr -d ':' | grep -E "^w" | head -1)

if [[ "$1" == "eth" ]]; then
    if ip link show "$eth" | grep -q "state UP"; then
        down=$(cat /sys/class/net/$eth/statistics/rx_bytes)
        echo "󰈀 $(ip addr show $eth | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)"
    else
        echo "󰈀 Offline"
    fi
elif [[ "$1" == "wifi" ]]; then
    if ip link show "$wifi" | grep -q "state UP"; then
        ssid=$(iwgetid -r $wifi 2>/dev/null)
        echo "󰤨 ${ssid}"
    else
        echo "󰤭 "
    fi
fi
