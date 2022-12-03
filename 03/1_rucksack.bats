setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_rucksack.sh </dev/null >/dev/null
}

@test "output" {
    ./1_rucksack.sh <test_input | tail -1 | grep '157'
}

@test "rucksack_priority" {
    assert_equal "$(rucksack_priority vJrwpWtwJgWrhcsFMMfFFhFp)" 16
}

@test "split_compartments" {
    assert_equal "$(split_compartments vJrwpWtwJgWrhcsFMMfFFhFp)" "vJrwpWtwJgWr"$'\n'"hcsFMMfFFhFp"
}

@test "find_only_missplaced" {
    assert_equal "$(find_only_missplaced vJrwpWtwJgWr hcsFMMfFFhFp)" "p"
}
