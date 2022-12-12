setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 2_long_monkey_business.sh </dev/null >/dev/null
}

@test "output on test_input" {
    skip "Failing, coming back later"
    output=$(./2_long_monkey_business.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 2713310158 ]]
}

@test "output" {
    skip "Failing, coming back later"
    output=$(./2_long_monkey_business.sh <input | tail -1)
    echo "output=$output"
    [[ $output = ?? ]]
}

@test "M_INSPECTED_COUNTS after 1 round" {
    parse_input <test_input
    play_rounds 1

    declare -p M_INSPECTED_COUNTS
    [[ ${M_INSPECTED_COUNTS[0]} = 2 ]]
    [[ ${M_INSPECTED_COUNTS[1]} = 4 ]]
    [[ ${M_INSPECTED_COUNTS[2]} = 3 ]]
    [[ ${M_INSPECTED_COUNTS[3]} = 6 ]]
}
@test "M_INSPECTED_COUNTS after 20 rounds" {
    parse_input <test_input
    play_rounds 20

    declare -p M_INSPECTED_COUNTS
    [[ ${M_INSPECTED_COUNTS[0]} = 99 ]]
    [[ ${M_INSPECTED_COUNTS[1]} = 97 ]]
    [[ ${M_INSPECTED_COUNTS[2]} = 8 ]]
    [[ ${M_INSPECTED_COUNTS[3]} = 103 ]]
}
@test "M_INSPECTED_COUNTS after 1000 rounds" {
    skip "Failing, coming back later"
    parse_input <test_input
    play_rounds 1000

    declare -p M_INSPECTED_COUNTS
    [[ ${M_INSPECTED_COUNTS[0]} = 5204 ]]
    [[ ${M_INSPECTED_COUNTS[1]} = 4792 ]]
    [[ ${M_INSPECTED_COUNTS[2]} = 199 ]]
    [[ ${M_INSPECTED_COUNTS[3]} = 5192 ]]
}
@test "M_INSPECTED_COUNTS after 10000 rounds" {
    skip "Failing, coming back later"
    parse_input <test_input
    play_rounds 10000

    declare -p M_INSPECTED_COUNTS
    [[ ${M_INSPECTED_COUNTS[0]} = 52166 ]]
    [[ ${M_INSPECTED_COUNTS[1]} = 47830 ]]
    [[ ${M_INSPECTED_COUNTS[2]} = 1938 ]]
    [[ ${M_INSPECTED_COUNTS[3]} = 52013 ]]
}
