#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

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

main
