#!/usr/bin/env bash

dir="$PWD"

if [[ "$dir" == "$HOME"* ]]; then
    dir="~${dir#$HOME}"
fi

IFS='/' read -ra parts <<< "$dir"
count=${#parts[@]}

if [[ "$dir" == ~* ]]; then
    prefix="~"
    remaining_parts=("${parts[@]:1}")
else
    if (( ${#parts[@]} <= 2 )); then
        echo "$dir"
        exit 0
    fi
    prefix="/${parts[1]}"
    remaining_parts=("${parts[@]:2}")
fi

if (( ${#remaining_parts[@]} > 3 )); then
    last3=("${remaining_parts[@]: -3}")
    printf -v joined_last3 "/%s" "${last3[@]}"
    echo "${prefix}/…${joined_last3}"
else
    echo "$dir"
fi
