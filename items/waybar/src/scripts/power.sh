#!/usr/bin/env bash

cap=$(cat /sys/class/power_supply/BAT0/capacity)
online=$(cat /sys/class/power_supply/ADP1/online)
if [ "$cap" -lt 30 ]; then
    color_class="low"
else
    color_class="normal"
fi
if [ "$online" -eq 1 ]; then 
    echo {\"text\": \"[󱐋 ${cap}% *󰚥]\", \"class\": \"$color_class\"}; 
else
    echo {\"text\": \"[󱐋 ${cap}%]\", \"class\": \"$color_class\"};
fi
