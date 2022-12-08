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

# walk_grid() {
#     local fn=$1 row=0 col=0
#     local value
#     while true; do
#         while true; do
#             value=$(get_grid_element "$row" "$col")
#             if [[ -z $value ]]; then
#                 if [[ $col -eq 0 ]]; then
#                     return
#                 else
#                     break
#                 fi
#             fi
#             $fn "$row" "$col" "$value"
#             col=$((col + 1))
#         done
#         row=$((row + 1))
#     done

#     for row in "${!GRID[@]}"; do
#         for ((col = 0; col < "$GRID_COL_COUNT"; col++)); do
#             $fn "$row" "$col" "$(get_grid_element "$row" "$col")"
#         done
#     done
# }

get_grid_element() {
    local row=$1 col=$2
    local row_content=${GRID[$row]}
    echo "${row_content:$col:1}"
}
