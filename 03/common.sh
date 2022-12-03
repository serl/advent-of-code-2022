#!/usr/bin/env bash

assert_equal() {
    if [[ $1 != "$2" ]]; then
        echo "$1 != $2"
        return 1
    fi
}

item_priority() {
    # Item types a through z have priorities 1 through 26
    # Item types A through Z have priorities 27 through 52
    ascii_code=$(printf %d "'$1")
    lowercase=$((ascii_code - 96))
    if [[ $lowercase -gt 0 ]]; then
        echo $lowercase
    else
        uppercase=$((lowercase + 58))
        echo $uppercase
    fi
}
