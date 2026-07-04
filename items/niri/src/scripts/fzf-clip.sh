#!/usr/bin/env bash

# Set fzf theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:-1,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

selected=$(cliphist list | fzf \
  --prompt="> " \
  --border \
  --info hidden \
  --preview='$HOME/.config/niri/scripts/preview.sh {}' \
  --preview-window=right:60%:wrap \
  --layout=reverse \
  --bind 'ctrl-u:preview-up,ctrl-d:preview-down' \
  --height=100% --border)

if [[ -n $selected ]]; then
    cliphist decode "$selected" | wl-copy
fi
