#!/usr/bin/env bash

# Laufende Polybars beenden
killall -q polybar

# Warten, bis sie komplett geschlossen sind
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Schleife über alle verbundenen Monitore aus xrandr
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload main &
  done
else
  polybar --reload main &
fi

