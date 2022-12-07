setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_sum_smaller_directories.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./1_sum_smaller_directories.sh <test_input | tail -1)
    [ "$output" = 95437 ]
}

@test "output" {
    output=$(./1_sum_smaller_directories.sh <input | tail -1)
    [ "$output" = 1307902 ]
}
