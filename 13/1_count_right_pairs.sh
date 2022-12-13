#!/usr/bin/env bash

main() {
    local pair_idx=1 sum=0 left right

    while IFS=$'\n' read -r line; do
        if [[ -z $left ]]; then
            left=$line
        elif [[ -z $right ]]; then
            right=$line
        elif [[ -z $line ]]; then
            if compare "$left" "$right"; then
                echo "Pair $pair_idx is right"
                sum=$((sum + pair_idx))
            fi
            pair_idx=$((pair_idx + 1))
            left=
            right=
        fi
    done
    echo $sum
}

compare() {
    local left=$1 right=$2 left_vals right_vals

    # shellcheck disable=SC2034 # left_vals is used by pop_element
    left_vals=$(unpack_list "$left")
    # shellcheck disable=SC2034 # right_vals is used by pop_element
    right_vals=$(unpack_list "$right")

    echo "L $left_vals $right_vals"

    while true; do
        pop_element left_vals left_el || return 0
        pop_element right_vals right_el || return 1

        # shellcheck disable=SC2154 # left_el and right_el are set by pop_element
        echo -n "E $left_el $right_el: "
        if [[ $left_el = "$right_el" ]]; then
            echo "equal"
            continue
        fi

        if is_list "$left_el" || is_list "$right_el"; then
            echo "list compare"
            if compare "$left_el" "$right_el"; then
                return 0
            else
                return 1
            fi
        else
            echo "direct compare"
            if [[ $left_el -lt $right_el ]]; then
                return 0
            else
                return 1
            fi
        fi
    done
}

unpack_list() {
    local list=$1 trim_end
    trim_end=${list%]}
    echo "${trim_end#[}"
}

pop_element() {
    local -n _list=$1
    local -n _output=${2:-ITEM}
    if [[ -z $_list ]]; then
        return 1
    elif is_list "$_list"; then
        item_len=$(find_list_len "$_list")
        _output=${_list:0:$item_len}
        _list=${_list:$((item_len + 1))}
    elif [[ $_list =~ , ]]; then
        _output=${_list%%,*}
        _list=${_list#*,}
    else
        _output=$_list
        _list=''
    fi
}
is_list() {
    local input=$1
    [[ ${input:0:1} = '[' ]]
}
find_list_len() {
    local input=$1 open_brakets=0 char
    for ((i = 0; i < ${#input}; i++)); do
        char=${input:$i:1}
        [[ $char = '[' ]] && open_brakets=$((open_brakets + 1))
        [[ $char = ']' ]] && open_brakets=$((open_brakets - 1))

        if [[ $open_brakets = 0 ]]; then
            echo $((i + 1))
            return
        fi
    done
}

main
