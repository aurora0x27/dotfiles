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
    prefix="/${parts[1]}"
    remaining_parts=("${parts[@]}")
fi

if (( ${#remaining_parts[@]} > 5 )); then
    last4=("${remaining_parts[@]: -4}")
    joined_last4=$(printf "/%s" "${last4[@]}")
    echo "$prefix/…${joined_last4}"
else
    echo "$dir"
fi
