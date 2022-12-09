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
    local row=$1 col=$2 walker_row=$3 walker_col=$4 walker_action=$5
    debug "walk_direction($*)" >&2
    shift 5

    local grid_row_count grid_col_count
    grid_row_count=$(grid_row_count)
    grid_col_count=$(grid_col_count)

    while row=$($walker_row "$row" "$grid_row_count") && col=$($walker_col "$col" "$grid_col_count"); do
        debug "walking($row, $col)" >&2
        $walker_action "$row" "$col" "$@" || break
    done
}
