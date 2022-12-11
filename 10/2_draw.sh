#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

parse_input

is_lit() {
    local column=$1 position=$2
    [[ $column -ge $((position - 1)) ]] &&
        [[ $column -le $((position + 1)) ]]
}

for cycle in "${!VALUE_X[@]}"; do
    column=$((cycle % 40))
    [[ $cycle -gt 0 ]] && [[ $column = 0 ]] && echo
    value=${VALUE_X[$cycle]}
    if is_lit "$column" "$value"; then
        echo -n '#'
    else
        echo -n '.'
    fi
done
