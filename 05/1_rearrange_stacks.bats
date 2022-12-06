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
