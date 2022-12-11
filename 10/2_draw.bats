setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 2_draw.sh </dev/null >/dev/null
    parse_input <test_input
}

@test "output on test_input" {
    output=$(./2_draw.sh <test_input | head -6)
    echo "output="$'\n'"$output"
    [[ $output = $(<test_expected_draw_output) ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./2_draw.sh <input | head -6)
    echo "output="$'\n'"$output"
    [[ $output = $(<expected_draw_output) ]]
}
