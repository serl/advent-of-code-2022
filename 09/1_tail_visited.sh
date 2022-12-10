#!/usr/bin/env bash

HEAD_X=0
HEAD_Y=0
TAIL_X=0
TAIL_Y=0
declare -A TAIL_VISITED

debug() {
    if [[ $DEBUG ]]; then
        echo "$@" >&2
    fi
}

main() {
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
    local i
    for ((i = 0; i < count; i++)); do
        move_head_step "$direction"
        tail_should_be_moved && move_tail
        record_tail_position
    done
}
move_head_step() {
    local direction=$1
    case $direction in
    L) HEAD_X=$((HEAD_X - 1)) ;;
    U) HEAD_Y=$((HEAD_Y + 1)) ;;
    D) HEAD_Y=$((HEAD_Y - 1)) ;;
    R) HEAD_X=$((HEAD_X + 1)) ;;
    esac
}

tail_should_be_moved() {
    local x_distance=$((HEAD_X - TAIL_X)) y_distance=$((HEAD_Y - TAIL_Y))
    debug "x_distance=$x_distance y_distance=$y_distance"
    [[ ${x_distance#-} -gt 1 ]] || [[ ${y_distance#-} -gt 1 ]]
}
move_tail() {
    local x_distance=$((HEAD_X - TAIL_X)) y_distance=$((HEAD_Y - TAIL_Y))

    debug "Move tail HEAD($HEAD_X, $HEAD_Y) TAIL($TAIL_X, $TAIL_Y)"

    if [[ $x_distance -gt 0 ]]; then
        TAIL_X=$((TAIL_X + 1))
    elif [[ $x_distance -lt 0 ]]; then
        TAIL_X=$((TAIL_X - 1))
    fi
    if [[ $y_distance -gt 0 ]]; then
        TAIL_Y=$((TAIL_Y + 1))
    elif [[ $y_distance -lt 0 ]]; then
        TAIL_Y=$((TAIL_Y - 1))
    fi
    debug "Moved tail to TAIL($TAIL_X, $TAIL_Y)"
}

record_tail_position() {
    TAIL_VISITED["$TAIL_X,$TAIL_Y"]=x
}

main
