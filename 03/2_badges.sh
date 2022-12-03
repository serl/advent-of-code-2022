#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

group_priority() {
    badge_item=$(badge_item "$1" "$2" "$3")
    item_priority "$badge_item"
}

badge_item() {
    for ((i = 0; i < ${#1}; i++)); do
        item="${1:$i:1}"
        if [[ $2 =~ $item ]] && [[ $3 =~ $item ]]; then
            echo "$item"
            return
        fi
    done
}

group=()
total=0
while IFS=$'\n' read -r line; do
    group+=("$line")
    if [[ ${#group[@]} = 3 ]]; then
        current=$(group_priority "${group[@]}")
        total=$((total + current))
        group=()
    fi
done

echo "The total is $total"
