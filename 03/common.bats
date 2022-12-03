setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source common.sh
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
