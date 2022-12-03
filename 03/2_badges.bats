setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 2_badges.sh </dev/null >/dev/null
}

@test "output" {
    ./2_badges.sh <test_input | tail -1 | grep '70'
}

@test "group_priority" {
    assert_equal "$(group_priority vJrwpWtwJgWrhcsFMMfFFhFp jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL PmmdzqPrVvPwwTWBwg)" 18
}

@test "badge_item" {
    assert_equal "$(badge_item vJrwpWtwJgWrhcsFMMfFFhFp jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL PmmdzqPrVvPwwTWBwg)" r
}
