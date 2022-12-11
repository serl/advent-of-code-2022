#!/usr/bin/env bash

debug() {
    if [[ $DEBUG ]]; then
        echo "$@" >&2
    fi
}

KNOTS_COUNT=0
KNOTS_X=
KNOTS_Y=
declare -A TAIL_VISITED

init_rope() {
    KNOTS_COUNT=$1
    KNOTS_X=()
    KNOTS_Y=()
    declare -A TAIL_VISITED

    local i
    for ((i = 0; i < KNOTS_COUNT; i++)); do
        KNOTS_X[$i]=0
        KNOTS_Y[$i]=0
    done
}

main() {
    local knots_count=$1
    init_rope "$knots_count"

    local direction count
    while IFS=$'\n' read -r line; do
        [[ $line =~ ^(([LUDR]) ([0-9]+))$ ]]
        direction=${BASH_REMATCH[2]}
        count=${BASH_REMATCH[3]}
        debug "Move HEAD by $count towards $direction"
        move_head "$direction" "$count"
    done
    declare -p TAIL_VISITED
    echo "${#TAIL_VISITED[@]}"
}

move_head() {
    local direction=$1 count=$2
    local i j
    for ((i = 0; i < count; i++)); do
        move_head_step "$direction"
        for ((j = 1; j < KNOTS_COUNT; j++)); do
            knot_should_be_moved "$j" &&
                move_knot "$j"
        done
        record_tail_position
    done
}
move_head_step() {
    local direction=$1
    case $direction in
    L) KNOTS_X[0]=$((KNOTS_X[0] - 1)) ;;
    U) KNOTS_Y[0]=$((KNOTS_Y[0] + 1)) ;;
    D) KNOTS_Y[0]=$((KNOTS_Y[0] - 1)) ;;
    R) KNOTS_X[0]=$((KNOTS_X[0] + 1)) ;;
    esac
    debug "> Moved HEAD(${KNOTS_X[0]}, ${KNOTS_Y[0]})"
}

knot_should_be_moved() {
    local cur_idx=$1
    local prev_idx=$((cur_idx - 1))
    local x_distance=$((KNOTS_X[prev_idx] - KNOTS_X[cur_idx])) y_distance=$((KNOTS_Y[prev_idx] - KNOTS_Y[cur_idx]))
    [[ ${x_distance#-} -gt 1 ]] || [[ ${y_distance#-} -gt 1 ]]
}
move_knot() {
    local cur_idx=$1
    local prev_idx=$((cur_idx - 1))
    local x_distance=$((KNOTS_X[prev_idx] - KNOTS_X[cur_idx])) y_distance=$((KNOTS_Y[prev_idx] - KNOTS_Y[cur_idx]))

    debug "# Moving KNOT$cur_idx(${KNOTS_X[$cur_idx]}, ${KNOTS_Y[$cur_idx]}) towards KNOT$prev_idx(${KNOTS_X[$prev_idx]}, ${KNOTS_Y[$prev_idx]})"

    if [[ $x_distance -gt 0 ]]; then
        KNOTS_X[$cur_idx]=$((KNOTS_X[cur_idx] + 1))
    elif [[ $x_distance -lt 0 ]]; then
        KNOTS_X[$cur_idx]=$((KNOTS_X[cur_idx] - 1))
    fi
    if [[ $y_distance -gt 0 ]]; then
        KNOTS_Y[$cur_idx]=$((KNOTS_Y[cur_idx] + 1))
    elif [[ $y_distance -lt 0 ]]; then
        KNOTS_Y[$cur_idx]=$((KNOTS_Y[cur_idx] - 1))
    fi
    debug "# Moved KNOT$cur_idx(${KNOTS_X[$cur_idx]}, ${KNOTS_Y[$cur_idx]})"
}

record_tail_position() {
    local tail_idx=$((KNOTS_COUNT - 1))
    TAIL_VISITED["${KNOTS_X[$tail_idx]},${KNOTS_Y[$tail_idx]}"]=x
}
