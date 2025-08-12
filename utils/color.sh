#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[36m'
MAGENTA='\033[35m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

color_echo() {
    local color="$1"
    shift
    echo -e "${!color}$*${RESET}"
}
