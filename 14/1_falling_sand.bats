setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_falling_sand.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./1_falling_sand.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 24 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./1_falling_sand.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 779 ]]
}
