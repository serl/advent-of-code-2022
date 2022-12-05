#!/usr/bin/env bash

first_contains_second() {
    local first_start=$1 first_end=$2 second_start=$3 second_end=$4
    [[ $first_start -ge $second_start ]] && [[ $first_end -le $second_end ]]
}

fully_contains() {
    first_contains_second "$@" || first_contains_second "$3" "$4" "$1" "$2"
}

check_pair() {
    [[ $1 =~ ^([0-9]+)-([0-9]+),([0-9]+)-([0-9]+)$ ]]
    fully_contains "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" "${BASH_REMATCH[3]}" "${BASH_REMATCH[4]}"
}

count=0
while IFS=$'\n' read -r line; do
    check_pair "$line" &&
        count=$((count + 1))
done

echo $count
