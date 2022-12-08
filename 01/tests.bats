setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}

@test "1 most calories on test_input" {
    output=$(./1_most_calories.sh <test_input)
    echo "output=$output"
    [[ $output = 'The Elf carrying the most Calories is carrying 24000 Calories' ]]
}

@test "1 most calories" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./1_most_calories.sh <input)
    echo "output=$output"
    [[ $output = 'The Elf carrying the most Calories is carrying 67016 Calories' ]]
}

@test "2 sum of top three on test_input" {
    output=$(./2_sum_of_top_three.sh <test_input)
    echo "output=$output"
    [[ $output = 'The top three Elves carrying the most Calories are carrying 45000 Calories' ]]
}

@test "2 sum of top three" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./2_sum_of_top_three.sh <input)
    echo "output=$output"
    [[ $output = 'The top three Elves carrying the most Calories are carrying 200116 Calories' ]]
}
