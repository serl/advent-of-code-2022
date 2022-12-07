#!/usr/bin/env bash

declare -A FILES
declare -A DIRECTORIES

calculate_directory_sizes() {
    for file_name in "${!FILES[@]}"; do
        size=${FILES[$file_name]}
        path=$file_name
        while [[ $path != / ]]; do
            path=$(dirname "$path")
            dir_size=${DIRECTORIES[$path]}
            DIRECTORIES[$path]=$((dir_size + size))
        done
    done
}

cd_command() {
    local cwd="$1" arg="$2"
    if [[ $arg = / ]]; then
        echo ''
    elif [[ $arg = .. ]]; then
        echo "${cwd%/*}"
    else
        echo "${cwd%/}/$arg"
    fi
}

parse_stdin() {
    cwd=
    while IFS=$'\n' read -r line; do
        if [[ $line =~ (\$ ([^ ]+)( (.+))?) ]]; then
            cmd=${BASH_REMATCH[2]}
            arg=${BASH_REMATCH[4]}
            if [[ $cmd = cd ]]; then
                cwd=$(cd_command "$cwd" "$arg")
            fi
        elif [[ $line =~ (([0-9]+) (.+)) ]]; then
            size=${BASH_REMATCH[2]}
            name=${BASH_REMATCH[3]}
            FILES["$cwd/$name"]=$size
        fi
    done

    declare -p FILES

    calculate_directory_sizes
    declare -p DIRECTORIES
}
