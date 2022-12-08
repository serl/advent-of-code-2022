setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}

@test "output on test_input 1" {
    output=$(echo mjqjpqmgbljsphdztnvjfqwrcgsmlb | ./1_find_start_of_packet.sh | tail -1)
    echo "output=$output"
    [[ $output = 7 ]]
}
@test "output on test_input 2" {
    output=$(echo bvwbjplbgvbhsrlpgdmjqwftvncz | ./1_find_start_of_packet.sh | tail -1)
    echo "output=$output"
    [[ $output = 5 ]]
}
@test "output on test_input 3" {
    output=$(echo nppdvjthqldpwncqszvftbrmjlhg | ./1_find_start_of_packet.sh | tail -1)
    echo "output=$output"
    [[ $output = 6 ]]
}
@test "output on test_input 4" {
    output=$(echo nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg | ./1_find_start_of_packet.sh | tail -1)
    echo "output=$output"
    [[ $output = 10 ]]
}
@test "output on test_input 5" {
    output=$(echo zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw | ./1_find_start_of_packet.sh | tail -1)
    echo "output=$output"
    [[ $output = 11 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./1_find_start_of_packet.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 1480 ]]
}
