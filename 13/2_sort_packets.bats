setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 2_sort_packets.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./2_sort_packets.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 140 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./2_sort_packets.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 23520 ]]
}
