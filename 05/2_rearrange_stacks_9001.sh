#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

move() {
    local from=$1 to=$2 count=$3
    items=${STACKS[$from]: -$count}
    STACKS[$from]=${STACKS[$from]:0:-$count}
    STACKS[$to]+=$items

    declare -p STACKS
}

main
