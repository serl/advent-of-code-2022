#!/usr/bin/env bash

read_header() {
    for i in $(seq $# -1 1); do
        line="${*:$i:1}"

        if [[ $line =~ [0-9] ]]; then
            create_empty_stacks "$line"
        elif [[ $line =~ \[ ]]; then
            fill_stacks_by_row "$line"
        fi
    done

    declare -p STACKS
}

create_empty_stacks() {
    local line="$1"
    STACKS=()

    while true; do
        label="$(read_header_col "$line" ${#STACKS[@]})"
        if [[ $label ]]; then
            STACKS[$label]=""
        else
            break
        fi
    done
}

fill_stacks_by_row() {
    local line="$1"

    index=0
    for label in "${!STACKS[@]}"; do
        crate=$(read_header_col "$line" "$index")
        [[ ${crate// /} ]] && STACKS[$label]+=$crate
        index=$((index + 1))
    done
}

read_header_col() {
    local line=$1 stack=$2
    idx=$((1 + 4 * stack))
    echo "${line:$idx:1}"
}

main() {
    local header=()
    while IFS=$'\n' read -r line; do
        if [[ $line =~ (move ([0-9]+) from ([0-9]+) to ([0-9]+)) ]]; then
            count="${BASH_REMATCH[2]}"
            from="${BASH_REMATCH[3]}"
            to="${BASH_REMATCH[4]}"
            move "$from" "$to" "$count"
        elif [[ $line ]]; then
            header+=("$line")
        else
            read_header "${header[@]}"
        fi
    done

    for items in "${STACKS[@]}"; do
        echo -n "${items: -1}"
    done
    echo
}
