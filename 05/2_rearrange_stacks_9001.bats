setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 2_rearrange_stacks_9001.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./2_rearrange_stacks_9001.sh <test_input | tail -1)
    echo "output=$output"
    [[ "$output" = MCD ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./2_rearrange_stacks_9001.sh <input | tail -1)
    echo "output=$output"
    [[ "$output" = BLSGJSDTS ]]
}

@test "move" {
    STACKS=()
    STACKS[1]="ABC"
    STACKS[2]=""

    move 1 2 2

    [[ ${STACKS[1]} = "A" ]]
    [[ ${STACKS[2]} = "BC" ]]
}
