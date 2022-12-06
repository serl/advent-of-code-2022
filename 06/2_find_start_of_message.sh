#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

find_start_of_message() {
    find_sequence "$1" 14
}

IFS=$'\n' read -r datastream || true
find_start_of_message "$datastream"
