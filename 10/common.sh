#!/usr/bin/env bash

debug() {
    if [[ $DEBUG ]]; then
        echo "$@" >&2
    fi
}

VALUE_X=()

parse_input() {
    local cycle=0 cmd argument value
    VALUE_X=(1)
    while IFS=$'\n' read -r line; do
        [[ $line =~ ^(([^ ]+)( (-?[0-9]+))?)$ ]]
        cmd=${BASH_REMATCH[2]}
        argument=${BASH_REMATCH[4]}
        value=${VALUE_X[$cycle]}
        case $cmd in
        noop)
            cycle=$((cycle + 1))
            VALUE_X[$cycle]=$value
            debug "NOOP/0 $cycle ${VALUE_X[$cycle]}"
            ;;
        addx)
            cycle=$((cycle + 1))
            VALUE_X[$cycle]=$value
            debug "ADDX/1 $cycle ${VALUE_X[$cycle]}"

            cycle=$((cycle + 1))
            VALUE_X[$cycle]=$((value + argument))
            debug "ADDX/2 $cycle ${VALUE_X[$cycle]}"
            ;;
        esac
    done
}
