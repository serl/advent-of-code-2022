#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

signal_strenght() {
    local cycle=$1
    echo $((cycle * VALUE_X[cycle - 1]))
}

parse_input
echo $(($(signal_strenght 20) + $(signal_strenght 60) + $(signal_strenght 100) + $(signal_strenght 140) + $(signal_strenght 180) + $(signal_strenght 220)))
