setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_count_right_pairs.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./1_count_right_pairs.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 13 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./1_count_right_pairs.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 6187 ]]
}
