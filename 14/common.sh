#!/usr/bin/env bash

export GRID=()
export GRID_WIDTH=0
export GRID_HEIGHT=0

parse_input() {
    local points=()
    while IFS=$'\n' read -r line; do
        readarray -t new_points < <(lines_to_points "$line")
        points+=("${new_points[@]}")
    done

    grid_bounds "${points[@]}"

    for point in "${points[@]}"; do
        [[ $point =~ ([0-9]+),([0-9]+) ]] || continue
        cur_x=${BASH_REMATCH[1]}
        cur_y=${BASH_REMATCH[2]}
        set_value "$cur_x" "$cur_y" '#'
    done
}

lines_to_points() {
    local line=$1 stops prev_x prev_y cur_x cur_y
    IFS='>' read -ra stops <<<"$line"
    for stop in "${stops[@]}"; do
        [[ $stop =~ ([0-9]+),([0-9]+) ]] || continue
        cur_x=${BASH_REMATCH[1]}
        cur_y=${BASH_REMATCH[2]}

        if [[ $prev_x ]] && [[ $prev_y ]]; then
            if [[ $prev_x = "$cur_x" ]]; then
                for y in $(seq "$prev_y" "$cur_y"); do
                    [[ $y = "$prev_y" ]] && continue
                    echo "$cur_x,$y"
                done
            elif [[ $prev_y = "$cur_y" ]]; then
                for x in $(seq "$prev_x" "$cur_x"); do
                    [[ $x = "$prev_x" ]] && continue
                    echo "$x,$cur_y"
                done
            fi
        else
            echo "$cur_x,$cur_y"
        fi

        prev_x=$cur_x
        prev_y=$cur_y
    done
}

grid_bounds() {
    local points=("$@") max_x=0 max_y=0
    for point in "${points[@]}"; do
        [[ $point =~ ([0-9]+),([0-9]+) ]]
        cur_x=${BASH_REMATCH[1]}
        cur_y=${BASH_REMATCH[2]}
        [[ $cur_x -gt $max_x ]] && max_x=$cur_x
        [[ $cur_y -gt $max_y ]] && max_y=$cur_y
    done
    GRID_WIDTH=$((max_x + 1))
    GRID_HEIGHT=$((max_y + 1))
}

set_value() {
    local cur_x=$1 cur_y=$2 value=$3
    GRID[cur_x + GRID_WIDTH * cur_y]=$value
}
get_value() {
    local cur_x=$1 cur_y=$2
    echo "${GRID[cur_x + GRID_WIDTH * cur_y]}"
}

print_grid() {
    local from_x=$1 to_x=$2 from_y=$3 to_y=$4 value

    for ((y = from_y; y <= to_y; y++)); do
        echo -n "$y "
        for ((x = from_x; x <= to_x; x++)); do
            value=$(get_value "$x" "$y")
            echo -n "${value:-.}"
        done
        echo
    done
}
