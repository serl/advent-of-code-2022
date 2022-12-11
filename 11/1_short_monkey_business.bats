setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_short_monkey_business.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./1_short_monkey_business.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 10605 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./1_short_monkey_business.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 88208 ]]
}

@test "play_round/1" {
    parse_input <test_input
    play_rounds 1

    declare -p M_ITEMS
    [[ ${M_ITEMS[0]} = '20, 23, 27, 26' ]]
    [[ ${M_ITEMS[1]} = '2080, 25, 167, 207, 401, 1046' ]]
    [[ ${M_ITEMS[2]} = '' ]]
    [[ ${M_ITEMS[3]} = '' ]]
}

@test "M_INSPECTED_COUNTS after 20 rounds" {
    parse_input <test_input
    play_rounds 20

    declare -p M_INSPECTED_COUNTS
    [[ ${M_INSPECTED_COUNTS[0]} = 101 ]]
    [[ ${M_INSPECTED_COUNTS[1]} = 95 ]]
    [[ ${M_INSPECTED_COUNTS[2]} = 7 ]]
    [[ ${M_INSPECTED_COUNTS[3]} = 105 ]]
}
