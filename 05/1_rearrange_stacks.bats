setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_rearrange_stacks.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./1_rearrange_stacks.sh <test_input | tail -1)
    [ "$output" = CMZ ]
}

@test "output" {
    output=$(./1_rearrange_stacks.sh <input | tail -1)
    [ "$output" = WCZTHTMPS ]
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

@test "move_one" {
    STACKS=()
    STACKS[1]="AB"
    STACKS[2]=""

    move_one 1 2

    [[ ${STACKS[1]} = "A" ]]
    [[ ${STACKS[2]} = "B" ]]
}

@test "move" {
    STACKS=()
    STACKS[1]="AB"
    STACKS[2]=""

    move 1 2 2

    [[ ${STACKS[1]} = "" ]]
    [[ ${STACKS[2]} = "BA" ]]
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
