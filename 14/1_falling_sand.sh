#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

main() {
    local count=0

    parse_input

    # print_grid 494 503 0 9
    while one_sand; do
        # print_grid 494 503 0 9
        count=$((count + 1))
    done

    echo $count
}

one_sand() {
    local cur_x=500 cur_y=0 next_y

    while true; do
        next_y=$((cur_y + 1))
        [[ $next_y -ge $GRID_HEIGHT ]] && return 1

        if ! [[ $(get_value $cur_x $next_y) ]]; then
            cur_y=$next_y
        elif ! [[ $(get_value $((cur_x - 1)) $next_y) ]]; then
            cur_x=$((cur_x - 1))
            cur_y=$next_y
        elif ! [[ $(get_value $((cur_x + 1)) $next_y) ]]; then
            cur_x=$((cur_x + 1))
            cur_y=$next_y
        else
            set_value $cur_x $cur_y 'o'
            return 0
        fi
    done
}

main
