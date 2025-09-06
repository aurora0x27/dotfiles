#! /usr/bin/bash

CONFIG_FILE=$HOME/.config/wallpaper.conf
WP="$HOME/.config/wallpapers/00.jpg"
BLUR_STREGTH=20
TRANSITION=simple
CACHE_DIR="$HOME/.cache/wallpaper"

[ -f "$CONFIG_FILE" ] && source "$CONFIG_FILE"

CACHE_IMG="$CACHE_DIR/wallpaper-blur.png"
CACHE_META="$CACHE_DIR/meta"

mkdir -p "$CACHE_DIR"

[[ -z "$WP" || ! -f "$WP" ]] && { echo "WARNING: No wallpapper selected: no such file" && exit 1; }

HASH=$(sha256sum "$WP")
HASH="$BLUR_STREGTH##$HASH"

if [ -f "$CACHE_META" ] && grep -q "$HASH" "$CACHE_META"; then
    echo "Using cached blurred wallpaper"
else
    echo "Generating blurred wallpaper..."
    ffmpeg -i "$WP" -vf "gblur=sigma=$BLUR_STREGTH" -y "$CACHE_IMG"
    echo "$HASH" > "$CACHE_META"
fi

pgrep -x swww-daemon >/dev/null || {
    echo "Starting daemon"
    swww-daemon -n wp-front &
    swww-daemon -n wp-back &
    sleep 1
}

swww img "$CACHE_IMG" -n wp-back --transition-type "$TRANSITION"
sleep 1
swww img "$WP" -n wp-front --transition-type "$TRANSITION"
