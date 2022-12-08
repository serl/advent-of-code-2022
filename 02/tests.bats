setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}

@test "1 rock paper scissors simple strategy on test_input" {
    output=$(./1_rock_paper_scissors_simple_strategy.sh <test_input)
    echo "output=$output"
    [[ $output = 'The total score is 15' ]]
}

@test "1 rock paper scissors simple strategy" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./1_rock_paper_scissors_simple_strategy.sh <input)
    echo "output=$output"
    [[ $output = 'The total score is 12586' ]]
}

@test "2 rock paper scissors complex strategy on test_input" {
    output=$(./2_rock_paper_scissors_complex_strategy.sh <test_input)
    echo "output=$output"
    [[ $output = 'The total score is 12' ]]
}

@test "2 rock paper scissors complex strategy" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./2_rock_paper_scissors_complex_strategy.sh <input)
    echo "output=$output"
    [[ $output = 'The total score is 13193' ]]
}
