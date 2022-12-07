#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

parse_stdin

sum=0
for dir_size in "${DIRECTORIES[@]}"; do
    [[ $dir_size -le 100000 ]] && sum=$((sum + dir_size))
done

echo $sum
