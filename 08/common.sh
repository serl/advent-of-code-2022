#!/usr/bin/env bash

export GRID=()

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
