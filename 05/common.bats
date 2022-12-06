setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source common.sh
}

@test "create_empty_stacks" {
    create_empty_stacks " 1   2 "
    [[ ${#STACKS[@]} = 2 ]]
    [[ ${STACKS[1]} = "" ]]
    [[ ${STACKS[2]} = "" ]]
}

@test "fill_stacks_by_row" {
    create_empty_stacks " 1   2 "
    fill_stacks_by_row "[A] [B]"
    fill_stacks_by_row "    [C]"
    [[ ${#STACKS[@]} = 2 ]]
    [[ ${STACKS[1]} = "A" ]]
    [[ ${STACKS[2]} = "BC" ]]
}

@test "read_header_col/stack" {
    [[ $(read_header_col " 1   2   3 " 2) == 3 ]]
}
@test "read_header_col/crate" {
    [[ $(read_header_col "[A] [B] [C]" 1) == B ]]
}
@test "read_header_col/not existing" {
    [[ $(read_header_col "[A] [B] [C]" 4) == '' ]]
}
