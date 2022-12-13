#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

PACKETS=()

main() {
    PACKETS=('[[2]]' '[[6]]')

    while IFS=$'\n' read -r line; do
        [[ $line ]] && PACKETS+=("$line")
    done
    sort2

    key_part_1=$(find_packet '[[2]]')
    key_part_2=$(find_packet '[[6]]')

    echo $((key_part_1 * key_part_2))
}

sort() {
    local swapped left_idx right_idx left_val right_val
    for ((i = 1; i < ${#PACKETS[@]}; i++)); do
        left_idx=$((i - 1))
        right_idx=$i
        left_val=${PACKETS[$left_idx]}
        right_val=${PACKETS[$right_idx]}
        if ! compare "$left_val" "$right_val"; then
            swapped=y
            PACKETS[$left_idx]=$right_val
            PACKETS[$right_idx]=$left_val
        fi
    done
    [[ $swapped ]] && sort
}

find_packet() {
    local item=$1
    for idx in "${!PACKETS[@]}"; do
        if [[ ${PACKETS[$idx]} = "$item" ]]; then
            echo $((idx + 1))
        fi
    done
}

main
