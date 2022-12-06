#!/usr/bin/env bash

find_sequence() {
    local datastream="$1" length="$2"
    local i
    for ((i = length; i <= ${#datastream}; i++)); do
        if all_different "${datastream:$((i - length)):$length}"; then
            echo "$i"
            return
        fi
    done
}

all_different() {
    local i
    for ((i = 0; i < ${#1}; i++)); do
        [[ ${1:$((i + 1))} =~ ${1:$i:1} ]] && return 1
    done
    return 0
}
