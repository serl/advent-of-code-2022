setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}

@test "1 rock paper scissors simple strategy" {
    ./1_rock_paper_scissors_simple_strategy.sh <test_input | grep '15'
}

@test "2 rock paper scissors complex strategy" {
    ./2_rock_paper_scissors_complex_strategy.sh <test_input | grep '12'
}
