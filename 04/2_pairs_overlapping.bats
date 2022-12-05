setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 2_pairs_overlapping.sh </dev/null >/dev/null
}

@test "output" {
    output=$(./2_pairs_overlapping.sh <test_input | tail -1)
    [ "$output" = 4 ]
}

@test "overlap/no overlap" {
    ! overlap 2 4 6 8
    ! overlap 6 8 2 4
}

@test "overlap/tails" {
    overlap 2 4 3 8
    overlap 3 8 2 4
}

@test "overlap/first edges second" {
    overlap 4 4 2 4
    overlap 2 2 2 4
}

@test "overlap/second edges first" {
    overlap 2 4 2 2
    overlap 2 4 4 4
}

@test "check_pair overlap" {
    check_pair 5-7,7-9
}

@test "check_pair inside overlap" {
    check_pair 6-6,4-6
}

@test "check_pair no overlap" {
    ! check_pair 1-2,5-6
}
