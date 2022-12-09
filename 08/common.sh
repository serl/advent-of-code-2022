#!/usr/bin/env bash

export GRID=()

debug() {
    if [[ $DEBUG ]]; then
        echo "$@" >&2
    fi
}

parse_stdin() {
    while IFS=$'\n' read -r line; do
        GRID+=("$line")
    done
    declare -p GRID
    echo "Size: ($(grid_row_count), $(grid_col_count))"
}

grid_row_count() {
    echo ${#GRID[@]}
}
grid_col_count() {
    echo ${#GRID[0]}
}

get_grid_element() {
    local row=$1 col=$2
    local row_content=${GRID[$row]}
    echo "${row_content:$col:1}"
}

walker_still() {
    echo "$1"
}
walker_backward() {
    local current=$1
    [[ $current -le 0 ]] && return 1
    echo $((current - 1))
}
walker_forward() {
    local current=$1 max=$2
    [[ $current -ge $((max - 1)) ]] && return 1
    echo $((current + 1))
}

walk_direction() {
    local row=$1 col=$2 walker_row=$3 walker_col=$4 walker_action=$5 origin_value
    origin_value=$(get_grid_element "$row" "$col")
    debug "walk_direction($*) [$origin_value]"

    local grid_row_count grid_col_count
    grid_row_count=$(grid_row_count)
    grid_col_count=$(grid_col_count)

    while row=$($walker_row "$row" "$grid_row_count") && col=$($walker_col "$col" "$grid_col_count"); do
        value=$(get_grid_element "$row" "$col")
        debug "walking($row, $col) [$value]"

        $walker_action "$row" "$col" "$value" "$origin_value" || break
    done
}

walk_all_directions() {
    local row=$1 col=$2 walker_action=$3 direction_action=${4:-echo}

    # going up
    $direction_action "$(walk_direction "$row" "$col" walker_backward walker_still "$walker_action")"
    # going left
    $direction_action "$(walk_direction "$row" "$col" walker_still walker_backward "$walker_action")"
    # going down?
    $direction_action "$(walk_direction "$row" "$col" walker_forward walker_still "$walker_action")"
    # going right
    $direction_action "$(walk_direction "$row" "$col" walker_still walker_forward "$walker_action")"
}
