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
    [[ $DEBUG ]] && echo

    is_visible_from_left "$row" "$col" ||
        is_visible_from_top "$row" "$col" ||
        is_visible_from_right "$row" "$col" ||
        is_visible_from_bottom "$row" "$col"
}
is_visible_from_left() {
    [[ $DEBUG ]] && echo left
    is_visible_from "$@" walker_still walker_backward
}
is_visible_from_top() {
    [[ $DEBUG ]] && echo top
    is_visible_from "$@" walker_backward walker_still
}
is_visible_from_right() {
    [[ $DEBUG ]] && echo right
    is_visible_from "$@" walker_still walker_forward
}
is_visible_from_bottom() {
    [[ $DEBUG ]] && echo bottom
    is_visible_from "$@" walker_forward walker_still
}
is_visible_from() {
    local row=$1 col=$2 next_row=$3 next_col=$4 value
    value=$(get_grid_element "$row" "$col")
    [[ $DEBUG ]] && echo "X $row $col $value"

    local grid_row_count grid_col_count
    grid_row_count=$(grid_row_count)
    grid_col_count=$(grid_col_count)

    while row=$($next_row "$row" "$grid_row_count") && col=$($next_col "$col" "$grid_col_count"); do
        compare_value=$(get_grid_element "$row" "$col")
        [[ $DEBUG ]] && echo "C $row $col $compare_value"
        [[ $compare_value -ge $value ]] &&
            return 1
    done
    [[ $DEBUG ]] && echo visible
    return 0
}

count_visible_trees
