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
    local row=$1 col=$2 result

    result=$(walk_all_directions "$row" "$col" is_visible_action)
    debug "result=$result"

    [[ $result != invisible$'\n'invisible$'\n'invisible$'\n'invisible ]]
}
is_visible_action() {
    local row=$1 col=$2 value=$3 origin_value=$4
    if [[ $value -ge $origin_value ]]; then
        echo invisible
        return 1
    fi
}

count_visible_trees
