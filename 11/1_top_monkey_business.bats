setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_top_monkey_business.sh </dev/null >/dev/null
    parse_input <test_input
}

@test "output on test_input" {
    output=$(./1_top_monkey_business.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 10605 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./1_top_monkey_business.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 88208 ]]
}
