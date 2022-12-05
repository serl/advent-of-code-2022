setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_pairs_fully_containing.sh </dev/null >/dev/null
}

@test "output" {
    output=$(./1_pairs_fully_containing.sh <test_input | tail -1)
    [ "$output" = 2 ]
}

@test "fully_contains/no overlap" {
    ! fully_contains 2 4 6 8
}

@test "fully_contains/partial overlap" {
    ! fully_contains 2 4 3 8
}

@test "fully_contains/second inside first" {
    fully_contains 1 8 2 7
}

@test "fully_contains/first inside second" {
    fully_contains 3 4 2 4
}

@test "fully_contains/first edges second" {
    fully_contains 4 4 2 4
    fully_contains 2 2 2 4
}

@test "fully_contains/second edges first" {
    fully_contains 2 4 2 2
    fully_contains 2 4 4 4
}

@test "check_pair overlap" {
    check_pair 6-6,4-6
}

@test "check_pair no overlap" {
    ! check_pair 1-2,5-6
}
