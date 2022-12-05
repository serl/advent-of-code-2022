#!/usr/bin/env bash

overlap() {
    local first_start=$1 first_end=$2 second_start=$3 second_end=$4

    if [[ $first_start -le $second_start ]]; then
        [[ $second_start -le $first_end ]]
    else
        [[ $first_start -le $second_end ]]
    fi
}

check_pair() {
    [[ $1 =~ ^([0-9]+)-([0-9]+),([0-9]+)-([0-9]+)$ ]]
    overlap "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" "${BASH_REMATCH[3]}" "${BASH_REMATCH[4]}"
}

count=0
while IFS=$'\n' read -r line; do
    check_pair "$line" &&
        count=$((count + 1))
done

echo $count
