setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}

@test "output on test_input" {
    output=$(./1_tail_visited.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 13 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./1_tail_visited.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 6023 ]]
}
