#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

parse_input

play_rounds "${1:-20}"

declare -p M_INSPECTED_COUNTS

IFS=$'\n' top_two=$(sort -nr <<<"${M_INSPECTED_COUNTS[*]}" | head -n2)
readarray -t top_two <<<"$top_two"
echo $((top_two[0] * top_two[1]))
