#!/usr/bin/env bash

value_for_stack() {
    local line=$1 stack=$2
    idx=$((1 + 4 * stack))
    echo "${line:$idx:1}"
}

declare -a stacks
initialize_stacks() {
    for i in $(seq $# -1 1); do
        line="${*:$i:1}"

        if [[ $line =~ [0-9] ]]; then
            while true; do
                label="$(value_for_stack "$line" ${#stacks[@]})"
                if [[ $label ]]; then
                    stacks[$label]=""
                else
                    break
                fi
            done
        elif [[ $line =~ \[ ]]; then
            index=0
            for label in "${!stacks[@]}"; do
                crate=$(value_for_stack "$line" "$index")
                [[ ${crate// /} ]] && stacks[$label]+=$crate
                index=$((index + 1))
            done
        fi
    done

    declare -p stacks
}

move_one() {
    local from=$1 to=$2
    item=${stacks[$from]: -1}
    stacks[$from]=${stacks[$from]:0:-1}
    stacks[$to]+=$item
}

move() {
    local from=$1 to=$2 count=$3
    for _ in $(seq "$count"); do
        move_one "$from" "$to"
    done
    declare -p stacks
}

header=()
while IFS=$'\n' read -r line; do
    if [[ $line =~ (move ([0-9]+) from ([0-9]+) to ([0-9]+)) ]]; then
        count="${BASH_REMATCH[2]}"
        from="${BASH_REMATCH[3]}"
        to="${BASH_REMATCH[4]}"
        move "$from" "$to" "$count"
    elif [[ $line ]]; then
        header+=("$line")
    else
        initialize_stacks "${header[@]}"
    fi
done

for items in "${stacks[@]}"; do
    echo -n "${items: -1}"
done
echo
