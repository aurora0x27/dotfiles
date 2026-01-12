proxy-status() {
    [[ -n ${ALL_PROXY} ]] && echo "ALL_PROXY: $ALL_PROXY" || echo "No proxy is on"
}

touchx() {
    [[ $# -eq 0 ]] && {
        echo "Touch executable files"
        echo ""
        echo "Usage: touchx file1 file2..."
        return 0
    }
    for name in "$@"; do
        mkdir -p $(dirname "$name")
        touch "$name" && chmod +x "$name"
    done
}
