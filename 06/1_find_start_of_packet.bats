setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_find_start_of_packet.sh </dev/null >/dev/null
}

@test "output on test_input 1" {
    output=$(echo mjqjpqmgbljsphdztnvjfqwrcgsmlb | ./1_find_start_of_packet.sh | tail -1)
    [ "$output" = 7 ]
}
@test "output on test_input 2" {
    output=$(echo bvwbjplbgvbhsrlpgdmjqwftvncz | ./1_find_start_of_packet.sh | tail -1)
    [ "$output" = 5 ]
}
@test "output on test_input 3" {
    output=$(echo nppdvjthqldpwncqszvftbrmjlhg | ./1_find_start_of_packet.sh | tail -1)
    [ "$output" = 6 ]
}
@test "output on test_input 4" {
    output=$(echo nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg | ./1_find_start_of_packet.sh | tail -1)
    [ "$output" = 10 ]
}
@test "output on test_input 5" {
    output=$(echo zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw | ./1_find_start_of_packet.sh | tail -1)
    [ "$output" = 11 ]
}

@test "output" {
    output=$(./1_find_start_of_packet.sh <input | tail -1)
    [ "$output" = 1480 ]
}

@test "find_start_of_packet/head" {
    [[ $(find_start_of_packet "abcdefghi") = 4 ]]
}
@test "find_start_of_packet/tail" {
    [[ $(find_start_of_packet "aaaaaaaaaaacde") = 14 ]]
}

@test "all_different/yes" {
    all_different "abcdef"
}

@test "all_different/no" {
    ! all_different "abcded"
}
