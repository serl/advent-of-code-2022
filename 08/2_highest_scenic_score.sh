#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

parse_stdin

highest_scenic_score() {
    local highest_score=0 grid_row_count grid_col_count
    grid_row_count=$(grid_row_count)
    grid_col_count=$(grid_col_count)

    for ((row = 0; row < "$grid_row_count"; row++)); do
        for ((col = 0; col < "$grid_col_count"; col++)); do
            current_score=$(scenic_score "$row" "$col")
            if [[ $current_score -gt $highest_score ]]; then
                echo "New high score: ($row, $col) $current_score"
                highest_score=$current_score
            fi
        done
    done
    echo "$highest_score"
}

scenic_score() {
    local row=$1 col=$2 trees_log

    trees_log=$(walk_all_directions "$row" "$col" viewing_distance_action tree_counter_action)
    readarray -t trees_log <<<"$trees_log"
    declare -p trees_log >&2

    echo $((trees_log[0] * trees_log[1] * trees_log[2] * trees_log[3]))
}

viewing_distance_action() {
    local row=$1 col=$2 value=$3 origin_value=$4
    if [[ $value -lt $origin_value ]]; then
        echo "smaller"
    else
        echo "bigger"
        return 1
    fi
}
tree_counter_action() {
    local direction_result=$1
    debug "direction_result=$direction_result"
    readarray -t direction_result < <(printf %s "$direction_result")
    declare -p direction_result >&2
    echo ${#direction_result[@]}
}

highest_scenic_score
