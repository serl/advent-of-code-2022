#!/usr/bin/env bash

rucksack_priority() {
    mapfile -t compartments < <(split_compartments "$1")
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

item_priority() {
    # Item types a through z have priorities 1 through 26
    # Item types A through Z have priorities 27 through 52
    ascii_code=$(printf %d "'$1")
    lowercase=$((ascii_code - 96))
    if [[ $lowercase -gt 0 ]]; then
        echo $lowercase
    else
        uppercase=$((lowercase + 58))
        echo $uppercase
    fi
}

total=0
while IFS=$'\n' read -r line; do
    current=$(rucksack_priority "$line")
    total=$((total + current))
done

echo "The total is $total"
