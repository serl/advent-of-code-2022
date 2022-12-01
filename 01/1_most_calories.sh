#!/usr/bin/env bash

max=0
current=0
while IFS=$'\n' read -r line; do
    [[ -z $line ]] && current=0
    current=$((current + line))
    [[ $current -gt $max ]] && max=$current
done

echo "The Elf carrying the most Calories is carrying $max Calories"
