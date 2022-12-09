setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 2_highest_scenic_score.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./2_highest_scenic_score.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 8 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./2_highest_scenic_score.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 496125 ]]
}

@test "scenic_score/example 1" {
    GRID=(
        30373
        25512
        65332
        33549
        35390
    )

    [[ $(scenic_score 1 2) = 4 ]]
}

@test "scenic_score/example 2" {
    GRID=(
        30373
        25512
        65332
        33549
        35390
    )

    [[ $(scenic_score 3 2) = 8 ]]
}

@test "scenic_score/edge is 0" {
    GRID=(
        30373
        25512
        65332
        33549
        35390
    )

    [[ $(scenic_score 2 0) = 0 ]]
}
