setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_tail_visited.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./1_tail_visited.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 13 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./1_tail_visited.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 6023 ]]
}

@test "move head/R 3" {
    HEAD_X=0
    HEAD_Y=0
    move_head R 3
    [[ $HEAD_X = 3 ]] && [[ $HEAD_Y = 0 ]]
}
@test "move head/U 3" {
    HEAD_X=0
    HEAD_Y=0
    move_head U 3
    [[ $HEAD_X = 0 ]] && [[ $HEAD_Y = 3 ]]
}
@test "move head/D 2" {
    HEAD_X=0
    HEAD_Y=0
    move_head D 2
    [[ $HEAD_X = 0 ]] && [[ $HEAD_Y = -2 ]]
}
@test "move head/L 3" {
    HEAD_X=0
    HEAD_Y=0
    move_head L 3
    [[ $HEAD_X = -3 ]] && [[ $HEAD_Y = 0 ]]
}

@test "tail_should_be_moved/no: over" {
    HEAD_X=0
    HEAD_Y=0
    TAIL_X=0
    TAIL_Y=0
    ! tail_should_be_moved
}
@test "tail_should_be_moved/no: contiguous vertical" {
    HEAD_X=0
    HEAD_Y=0
    TAIL_X=0
    TAIL_Y=1
    ! tail_should_be_moved
    TAIL_Y=-1
    ! tail_should_be_moved
}
@test "tail_should_be_moved/no: contiguous horizontal" {
    HEAD_X=0
    HEAD_Y=0
    TAIL_X=1
    TAIL_Y=0
    ! tail_should_be_moved
    TAIL_X=-1
    ! tail_should_be_moved
}
@test "tail_should_be_moved/no: contiguous diagonal" {
    HEAD_X=0
    HEAD_Y=0
    TAIL_X=1
    TAIL_Y=1
    ! tail_should_be_moved
    TAIL_X=-1
    TAIL_Y=-1
    ! tail_should_be_moved
    TAIL_X=-1
    TAIL_Y=1
    ! tail_should_be_moved
    TAIL_X=1
    TAIL_Y=-1
    ! tail_should_be_moved
}
@test "tail_should_be_moved/yes" {
    HEAD_X=0
    HEAD_Y=0
    TAIL_X=0
    TAIL_Y=2
    tail_should_be_moved
    TAIL_X=2
    TAIL_Y=0
    tail_should_be_moved
    TAIL_X=2
    TAIL_Y=2
    tail_should_be_moved
}

@test "move_tail/horizontal+" {
    HEAD_X=2
    HEAD_Y=0
    TAIL_X=0
    TAIL_Y=0
    tail_should_be_moved
    move_tail
    [[ $TAIL_X = 1 ]] && [[ $TAIL_Y = 0 ]]
}
@test "move_tail/horizontal-" {
    HEAD_X=-2
    HEAD_Y=0
    TAIL_X=0
    TAIL_Y=0
    tail_should_be_moved
    move_tail
    [[ $TAIL_X = -1 ]] && [[ $TAIL_Y = 0 ]]
}
@test "move_tail/vertical+" {
    HEAD_X=0
    HEAD_Y=2
    TAIL_X=0
    TAIL_Y=0
    tail_should_be_moved
    move_tail
    [[ $TAIL_X = 0 ]] && [[ $TAIL_Y = 1 ]]
}
@test "move_tail/vertical-" {
    HEAD_X=0
    HEAD_Y=-2
    TAIL_X=0
    TAIL_Y=0
    tail_should_be_moved
    move_tail
    [[ $TAIL_X = 0 ]] && [[ $TAIL_Y = -1 ]]
}
@test "move_tail/diagonal 1" {
    HEAD_X=1
    HEAD_Y=2
    TAIL_X=0
    TAIL_Y=0
    tail_should_be_moved
    move_tail
    [[ $TAIL_X = 1 ]] && [[ $TAIL_Y = 1 ]]
}
@test "move_tail/diagonal 2" {
    HEAD_X=2
    HEAD_Y=1
    TAIL_X=0
    TAIL_Y=0
    tail_should_be_moved
    move_tail
    [[ $TAIL_X = 1 ]] && [[ $TAIL_Y = 1 ]]
}
