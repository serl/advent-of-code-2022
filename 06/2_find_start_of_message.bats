setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}

@test "output on test_input 1" {
    output=$(echo mjqjpqmgbljsphdztnvjfqwrcgsmlb | ./2_find_start_of_message.sh | tail -1)
    echo "output=$output"
    [[ "$output" = 19 ]]
}
@test "output on test_input 2" {
    output=$(echo bvwbjplbgvbhsrlpgdmjqwftvncz | ./2_find_start_of_message.sh | tail -1)
    echo "output=$output"
    [[ "$output" = 23 ]]
}
@test "output on test_input 3" {
    output=$(echo nppdvjthqldpwncqszvftbrmjlhg | ./2_find_start_of_message.sh | tail -1)
    echo "output=$output"
    [[ "$output" = 23 ]]
}
@test "output on test_input 4" {
    output=$(echo nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg | ./2_find_start_of_message.sh | tail -1)
    echo "output=$output"
    [[ "$output" = 29 ]]
}
@test "output on test_input 5" {
    output=$(echo zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw | ./2_find_start_of_message.sh | tail -1)
    echo "output=$output"
    [[ "$output" = 26 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./2_find_start_of_message.sh <input | tail -1)
    echo "output=$output"
    [[ "$output" = 2746 ]]
}
