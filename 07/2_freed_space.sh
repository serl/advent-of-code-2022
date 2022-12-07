#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

parse_stdin

NEEDED_SPACE=30000000
TOTAL_SPACE=70000000

USED_SPACE=${DIRECTORIES["/"]}
FREE_SPACE=$((TOTAL_SPACE - USED_SPACE))

MIN_SPACE_TO_FREE=$((NEEDED_SPACE - FREE_SPACE))

deleting_dir_size=$USED_SPACE
for dir_size in "${DIRECTORIES[@]}"; do
    if [[ $dir_size -ge $MIN_SPACE_TO_FREE ]] && [[ $dir_size -lt $deleting_dir_size ]]; then
        deleting_dir_size=$dir_size
    fi
done
echo $deleting_dir_size
