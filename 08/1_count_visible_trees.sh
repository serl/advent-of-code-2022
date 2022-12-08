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
    next_row() {
        echo "$1"
    }
    next_col() {
        local current=$1
        [[ $current = 0 ]] && return 1
        echo $((current - 1))
    }
    [[ $DEBUG ]] && echo left
    is_visible_from "$@"
}
is_visible_from_top() {
    next_row() {
        local current=$1
        [[ $current = 0 ]] && return 1
        echo $((current - 1))
    }
    next_col() {
        echo "$1"
    }
    [[ $DEBUG ]] && echo top
    is_visible_from "$@"
}
is_visible_from_right() {
    local grid_col_count
    grid_col_count=$(grid_col_count)
    next_row() {
        echo "$1"
    }
    next_col() {
        local current=$1
        [[ $current -ge $((grid_col_count - 1)) ]] && return 1
        echo $((current + 1))
    }
    [[ $DEBUG ]] && echo right
    is_visible_from "$@"
}
is_visible_from_bottom() {
    local grid_row_count
    grid_row_count=$(grid_row_count)
    next_row() {
        local current=$1
        [[ $current -ge $((grid_row_count - 1)) ]] && return 1
        echo $((current + 1))
    }
    next_col() {
        echo "$1"
    }
    [[ $DEBUG ]] && echo bottom
    is_visible_from "$@"
}
is_visible_from() {
    local row=$1 col=$2 value
    value=$(get_grid_element "$row" "$col")
    [[ $DEBUG ]] && echo "X $row $col $value"

    while row=$(next_row "$row") && col=$(next_col "$col"); do
        compare_value=$(get_grid_element "$row" "$col")
        [[ $DEBUG ]] && echo "C $row $col $compare_value"
        [[ $compare_value -ge $value ]] &&
            return 1
    done
    [[ $DEBUG ]] && echo visible
    return 0
}

count_visible_trees
