setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source common.sh
}

@test "find_sequence/head" {
    [[ $(find_sequence "abcdefghi" 4) = 4 ]]
}
@test "find_sequence/tail" {
    [[ $(find_sequence "aaaaaaaaaaacde" 4) = 14 ]]
}

@test "all_different/yes" {
    all_different "abcdef"
}
@test "all_different/no" {
    ! all_different "abcded"
}
