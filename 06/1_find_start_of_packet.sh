#!/usr/bin/env bash

find_start_of_packet() {
    local datastream="$1" packet_length=4
    local i
    for ((i = packet_length; i <= ${#datastream}; i++)); do
        if all_different "${datastream:$((i - packet_length)):$packet_length}"; then
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

IFS=$'\n' read -r datastream || true
find_start_of_packet "$datastream"
