setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 2_freed_space.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./2_freed_space.sh <test_input | tail -1)
    [ "$output" = 24933642 ]
}

@test "output" {
    output=$(./2_freed_space.sh <input | tail -1)
    [ "$output" = 7068748 ]
}
