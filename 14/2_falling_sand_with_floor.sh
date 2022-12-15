#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

main() {
    local count=0

    parse_input

    # print_grid 488 511 0 11
    while one_sand; do
        # print_grid 488 511 0 11
        # echo
        count=$((count + 1))
    done
    # print_grid 488 511 0 11

    echo $count
}

one_sand() {
    local cur_x=500 cur_y=0 next_y

    [[ $(get_value_or_floor $cur_x $cur_y) ]] && return 1

    while true; do
        next_y=$((cur_y + 1))

        if ! [[ $(get_value_or_floor $cur_x $next_y) ]]; then
            cur_y=$next_y
        elif ! [[ $(get_value_or_floor $((cur_x - 1)) $next_y) ]]; then
            cur_x=$((cur_x - 1))
            cur_y=$next_y
        elif ! [[ $(get_value_or_floor $((cur_x + 1)) $next_y) ]]; then
            cur_x=$((cur_x + 1))
            cur_y=$next_y
        else
            set_value $cur_x $cur_y 'o'
            return 0
        fi

    done
}

get_value_or_floor() {
    local x=$1 y=$2

    if [[ $y -ge $((GRID_HEIGHT + 1)) ]]; then
        echo '#'
        return
    fi
    get_value "$x" "$y"
}

main
