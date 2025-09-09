printf '\033[2J\033[H'
if cliphist decode "$1" | magick identify - &>/dev/null; then
    cliphist decode "$1" | magick - -geometry 720x540 sixel:- 
    # cliphist decode "$1" | magick - -resize 800x600 png:- | kitty +kitten icat --stdin yes --align left --hold
else
    cliphist decode "$1"
fi
