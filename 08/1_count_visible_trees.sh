#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

parse_stdin

count_visible_trees() {
    local visible_trees=0 grid_row_count grid_col_count
    grid_row_count=$(grid_row_count)
    grid_col_count=$(grid_col_count)

    for ((row = 0; row < "$grid_row_count"; row++)); do
        for ((col = 0; col < "$grid_col_count"; col++)); do
            if is_visible "$row" "$col"; then
                visible_trees=$((visible_trees + 1))
            fi
        done
    done
    echo $visible_trees
}

is_visible() {
    local row=$1 col=$2
    debug ""

    is_visible_from_left "$row" "$col" ||
        is_visible_from_top "$row" "$col" ||
        is_visible_from_right "$row" "$col" ||
        is_visible_from_bottom "$row" "$col"
}
is_visible_from_left() {
    debug "from left"
    is_visible_from "$@" walker_still walker_backward
}
is_visible_from_top() {
    debug "from top"
    is_visible_from "$@" walker_backward walker_still
}
is_visible_from_right() {
    debug "from right"
    is_visible_from "$@" walker_still walker_forward
}
is_visible_from_bottom() {
    debug "from bottom"
    is_visible_from "$@" walker_forward walker_still
}

is_visible_from() {
    local row=$1 col=$2 value result
    value=$(get_grid_element "$row" "$col")
    result=$(walk_direction "$@" is_visible_action "$value")
    debug "Result=$result"
    [[ $result != invisible ]]
}
is_visible_action() {
    local row=$1 col=$2 origin_value=$3 value
    value=$(get_grid_element "$row" "$col")
    if [[ $value -ge $origin_value ]]; then
        echo invisible
        return 1
    fi
}

count_visible_trees
