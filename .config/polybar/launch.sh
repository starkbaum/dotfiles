#!/bin/bash
# Kill any running polybar instances
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Get screen width and calculate polybar width matching i3 gaps
SCREEN_WIDTH=$(xrandr | grep '\*' | awk '{print $1}' | cut -d'x' -f1 | head -1)
GAPS=15  # gaps outer (5) + gaps inner (10)
BAR_WIDTH=$((SCREEN_WIDTH - (2 * GAPS)))
OFFSET_X=$GAPS

# Export for polybar
export BAR_WIDTH
export OFFSET_X

# Launch polybar
BAR_WIDTH=$BAR_WIDTH OFFSET_X=$OFFSET_X polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched... (width: $BAR_WIDTH, offset: $OFFSET_X)"
