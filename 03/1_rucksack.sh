#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

rucksack_priority() {
    readarray -t compartments < <(split_compartments "$1")
    missplaced=$(find_only_missplaced "${compartments[0]}" "${compartments[1]}")
    item_priority "$missplaced"
}

split_compartments() {
    local rucksack="$1"
    local len=${#rucksack}
    echo "${rucksack:0:$((len / 2))}"
    echo "${rucksack:$((len / 2))}"
}

find_only_missplaced() {
    for ((i = 0; i < ${#1}; i++)); do
        item="${1:$i:1}"
        if [[ $2 =~ $item ]]; then
            echo "$item"
            return
        fi
    done
}

total=0
while IFS=$'\n' read -r line; do
    current=$(rucksack_priority "$line")
    total=$((total + current))
done

echo "The total is $total"
