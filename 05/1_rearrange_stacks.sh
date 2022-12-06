#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

move() {
    local from=$1 to=$2 count=$3
    for _ in $(seq "$count"); do
        move_one "$from" "$to"
    done
    declare -p STACKS
}

move_one() {
    local from=$1 to=$2
    item=${STACKS[$from]: -1}
    STACKS[$from]=${STACKS[$from]:0:-1}
    STACKS[$to]+=$item
}

main
