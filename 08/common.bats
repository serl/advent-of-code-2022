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
