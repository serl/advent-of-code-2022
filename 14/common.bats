setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source common.sh
}

@test "lines_to_points/two stops" {
    output=$(lines_to_points "498,4 -> 498,6")
    echo "output=$output"
    expected="498,4"$'\n'"498,5"$'\n'"498,6"
    [[ $output = "$expected" ]]
}
@test "lines_to_points/four stops" {
    output=$(lines_to_points "503,4 -> 502,4 -> 502,9 -> 494,9")
    echo "output=$output"
    expected="503,4"$'\n'"502,4"$'\n'"502,5"$'\n'"502,6"$'\n'"502,7"$'\n'"502,8"$'\n'"502,9"$'\n'"501,9"$'\n'"500,9"$'\n'"499,9"$'\n'"498,9"$'\n'"497,9"$'\n'"496,9"$'\n'"495,9"$'\n'"494,9"

    [[ $output = "$expected" ]]
}

@test "grid_bounds" {
    grid_bounds 3,2 4,5
    echo "GRID_WIDTH=$GRID_WIDTH"
    echo "GRID_HEIGHT=$GRID_HEIGHT"
    [[ $GRID_WIDTH = 5 ]]
    [[ $GRID_HEIGHT = 6 ]]
}
