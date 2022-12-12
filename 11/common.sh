#!/usr/bin/env bash

debug() {
    if [[ $DEBUG ]]; then
        echo "$@" >&2
    fi
}

export M_ITEMS=()
export M_OPERATIONS=()
export M_TESTS_DIVISIBLE=()
export M_DESTINATION_IF_TRUE=()
export M_DESTINATION_IF_FALSE=()

export M_INSPECTED_COUNTS=()

parse_input() {
    local monkey_idx

    M_ITEMS=()
    M_OPERATIONS=()
    M_TESTS_DIVISIBLE=()
    M_DESTINATION_IF_TRUE=()
    M_DESTINATION_IF_FALSE=()
    M_INSPECTED_COUNTS=()

    while IFS=$'\n' read -r line; do
        if [[ $line =~ (Monkey ([0-9]+)) ]]; then
            monkey_idx=${BASH_REMATCH[2]}
            M_INSPECTED_COUNTS[$monkey_idx]=0
        elif [[ $line =~ (Starting items: ([0-9, ]+)) ]]; then
            M_ITEMS[$monkey_idx]=${BASH_REMATCH[2]}
        elif [[ $line =~ (Operation: new = (.+)) ]]; then
            M_OPERATIONS[$monkey_idx]=${BASH_REMATCH[2]//old/ITEM}
        elif [[ $line =~ (Test: divisible by ([0-9]+)) ]]; then
            M_TESTS_DIVISIBLE[$monkey_idx]=${BASH_REMATCH[2]}
        elif [[ $line =~ (If true: throw to monkey ([0-9]+)) ]]; then
            M_DESTINATION_IF_TRUE[$monkey_idx]=${BASH_REMATCH[2]}
        elif [[ $line =~ (If false: throw to monkey ([0-9]+)) ]]; then
            M_DESTINATION_IF_FALSE[$monkey_idx]=${BASH_REMATCH[2]}
        fi
    done

    declare -p M_ITEMS
    declare -p M_OPERATIONS
    declare -p M_TESTS_DIVISIBLE
    declare -p M_DESTINATION_IF_TRUE
    declare -p M_DESTINATION_IF_FALSE
}

pop_item() {
    local monkey_idx=$1
    local -n _output=${2:-ITEM}
    if [[ -z ${M_ITEMS[$monkey_idx]} ]]; then
        return 1
    elif [[ ${M_ITEMS[$monkey_idx]} =~ , ]]; then
        _output=${M_ITEMS[$monkey_idx]%%, *}
        M_ITEMS[$monkey_idx]=${M_ITEMS[$monkey_idx]#*, }
    else
        _output=${M_ITEMS[$monkey_idx]}
        M_ITEMS[$monkey_idx]=''
    fi
}

push_item() {
    local monkey_idx=$1 item=$2
    if [[ ${M_ITEMS[$monkey_idx]} ]]; then
        M_ITEMS[$monkey_idx]="${M_ITEMS[$monkey_idx]}, $item"
    else
        M_ITEMS[$monkey_idx]=$item
    fi
}

play_round() {
    for monkey_idx in "${!M_ITEMS[@]}"; do
        # debug "Monkey $monkey_idx:"
        while pop_item "$monkey_idx"; do
            # shellcheck disable=SC2153 # ITEM is set by pop_item
            # debug "> popped $ITEM"

            new_value=$((M_OPERATIONS[monkey_idx]))
            [[ $ITEM_STATIC_DIVISOR ]] && new_value=$((new_value / ITEM_STATIC_DIVISOR))
            # debug "> > new value: $new_value"

            modulus=$((new_value % M_TESTS_DIVISIBLE[monkey_idx]))
            if [[ $modulus = 0 ]]; then
                next_monkey_idx=${M_DESTINATION_IF_TRUE[$monkey_idx]}
                # debug "> > divisible by ${M_TESTS_DIVISIBLE[$monkey_idx]} -> $next_monkey_idx"
            else
                next_monkey_idx=${M_DESTINATION_IF_FALSE[$monkey_idx]}
                # debug "> > not divisible by ${M_TESTS_DIVISIBLE[$monkey_idx]} -> $next_monkey_idx"
            fi

            push_item "$next_monkey_idx" "$new_value"

            M_INSPECTED_COUNTS[$monkey_idx]=$((M_INSPECTED_COUNTS[monkey_idx] + 1))
        done
    done
}

play_rounds() {
    local rounds=$1
    for ((i = 0; i < rounds; i++)); do
        play_round
    done
}
