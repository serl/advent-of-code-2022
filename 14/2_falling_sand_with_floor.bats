setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 2_falling_sand_with_floor.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./2_falling_sand_with_floor.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 93 ]]
}

@test "output" {
    skip "Takes about 1h to run"
    output=$(./2_falling_sand_with_floor.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 27426 ]]
}
