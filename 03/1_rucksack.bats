setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_rucksack.sh </dev/null >/dev/null
}

@test "output" {
    ./1_rucksack.sh <test_input | tail -1 | grep '157'
}

assert_equal() {
    if [[ $1 != $2 ]]; then
        echo "$1 != $2"
        return 1
    fi
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

@test "item_priority a" {
    item_priority=$(item_priority a)
    assert_equal $item_priority 1
}

@test "item_priority z" {
    item_priority=$(item_priority z)
    assert_equal $item_priority 26
}

@test "item_priority A" {
    item_priority=$(item_priority A)
    assert_equal $item_priority 27
}

@test "item_priority Z" {
    item_priority=$(item_priority Z)
    assert_equal $item_priority 52
}
