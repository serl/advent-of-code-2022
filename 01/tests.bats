setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}

@test "1 most calories" {
    ./1_most_calories.sh <test_input | grep '24000'
}

@test "2 sum of top three" {
    ./2_sum_of_top_three.sh <test_input | grep '45000'
}
