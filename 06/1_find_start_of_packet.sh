#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit
source common.sh

find_start_of_packet() {
    find_sequence "$1" 4
}

IFS=$'\n' read -r datastream || true
find_start_of_packet "$datastream"
