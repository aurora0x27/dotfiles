#!/bin/bash
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
gsettings set org.gnome.desktop.interface gtk-theme "$(cat ~/.config/gtk-theme.d/settings/theme-light)"
