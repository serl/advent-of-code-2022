setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 2_badges.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./2_badges.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 'The total is 70' ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./2_badges.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 'The total is 2633' ]]
}

@test "group_priority" {
    assert_equal "$(group_priority vJrwpWtwJgWrhcsFMMfFFhFp jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL PmmdzqPrVvPwwTWBwg)" 18
}

@test "badge_item" {
    assert_equal "$(badge_item vJrwpWtwJgWrhcsFMMfFFhFp jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL PmmdzqPrVvPwwTWBwg)" r
}
