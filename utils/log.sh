#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/color.sh"

log_info() {
    echo -e "${BLUE}[INFO] $* ${RESET}"
}

log_warn() {
    echo -e "${YELLOW}[WARN] $* ${RESET}"
}

log_error() {
    echo -e "${RED}[ERROR] $* ${RESET}" >&2
}

log_success() {
    echo -e "${GREEN}[OK] $* ${RESET}"
}

log_debug() {
    [[ "${debug:-}" == 1 ]] && echo -e "${BOLD}[DEBUG]${RESET} $*"
}
