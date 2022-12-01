#!/usr/bin/env bash

elves=()
current_index=0
while IFS=$'\n' read -r line; do
    [[ -z $line ]] && ((current_index++))
    elves[$current_index]=$((elves[current_index] + line))
done

IFS=$'\n' top_three=$(sort -nr <<<"${elves[*]}" | head -n3)

sum=0
for item in $top_three; do
    sum=$((sum + item))
done

echo "The top three Elves carrying the most Calories are carrying $sum Calories"
