setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_count_visible_trees.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./1_count_visible_trees.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 21 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./1_count_visible_trees.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 1538 ]]
}

@test "is_visible/0-edge" {
    GRID=(
        111
        111
    )

    is_visible 0 1
    is_visible 1 0
}
@test "is_visible/far-edge" {
    GRID=(
        7332
        5991
        6560
    )

    is_visible 1 3
    is_visible 2 1
    is_visible 2 3
}
@test "is_visible/not visible" {
    GRID=(
        999
        999
        999
    )

    ! is_visible 1 1
}
@test "is_visible/row left" {
    GRID=(
        9999
        1199
        9999
    )

    is_visible 1 2
}
@test "is_visible/row right" {
    GRID=(
        9999
        9911
        9999
    )

    is_visible 1 1
}
@test "is_visible/col top" {
    GRID=(
        919
        919
        999
        999
    )

    is_visible 2 1
}
@test "is_visible/col bottom" {
    GRID=(
        999
        999
        919
        919
    )

    is_visible 1 1
}
