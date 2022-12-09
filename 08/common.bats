setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source common.sh
}

@test "grid_row_count empty" {
    GRID=()
    [[ $(grid_row_count) = 0 ]]
}
@test "grid_row_count fill" {
    GRID=(
        1
        2
        3
    )
    [[ $(grid_row_count) = 3 ]]
}
@test "grid_col_count empty" {
    GRID=()
    [[ $(grid_col_count) = 0 ]]
}
@test "grid_col_count fill" {
    GRID=(
        123
    )
    [[ $(grid_col_count) = 3 ]]
}

@test "get_grid_element existing" {
    GRID=(
        732
        551
        653
    )

    [[ $(get_grid_element 1 1) = 5 ]]
}
@test "get_grid_element missing" {
    GRID=(
        123
    )

    [[ $(get_grid_element 10 10) = '' ]]
}

@test "walker_still" {
    [[ $(walker_still 4) == 4 ]]
}
@test "walker_backward middle" {
    [[ $(walker_backward 4) == 3 ]]
}
@test "walker_backward start" {
    ! walker_backward 0
}
@test "walker_forward middle" {
    [[ $(walker_forward 4 10) == 5 ]]
}
@test "walker_forward end" {
    ! walker_forward 10 10
}
