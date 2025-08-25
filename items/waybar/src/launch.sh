#!/usr/bin/env bash

dir=~/.config/waybar

cur_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')
way_monitor=$(cat $dir/monitor.jsonc | jq -r .output)

function startwaybar() {
    theme="$1"

    echo "{ \"output\": \"$cur_monitor\" }" >$dir/monitor.jsonc

    config=$dir/theme/$theme/config.jsonc

    ln -s $dir/theme/"$theme"/dark.css $dir/style-dark.css -f
    ln -s $dir/theme/"$theme"/light.css $dir/style-light.css -f
    ln -s $dir/theme/"$theme"/style.css $dir/base.css -f

    LANG=en_US.UTF-8 waybar -c "$config"
}

theme="${1:-"ml4w"}"

if test "$cur_monitor" = "$way_monitor"; then
    pkill waybar || startwaybar "$theme"
else
    pkill waybar
    startwaybar "$theme"
fi
