setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}

@test "output on test_input" {
    output=$(./2_long_tail_visited.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 1 ]]
}

@test "output on test_input_2" {
    output=$(./2_long_tail_visited.sh <test_input_2 | tail -1)
    echo "output=$output"
    [[ $output = 36 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./2_long_tail_visited.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 2533 ]]
}
