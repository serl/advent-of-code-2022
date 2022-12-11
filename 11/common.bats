setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source common.sh
}

@test "pop_item/multiple" {
    M_ITEMS=('1, 2, 3')

    pop_item 0

    [[ $ITEM = '1' ]]
    [[ ${M_ITEMS[0]} = '2, 3' ]]
}
@test "pop_item/last" {
    M_ITEMS=('42')

    pop_item 0

    [[ $ITEM = '42' ]]
    [[ ${M_ITEMS[0]} = '' ]]
}
@test "pop_item/empty" {
    M_ITEMS=('')

    ! pop_item 0
}

@test "push_item/first" {
    M_ITEMS=('')

    push_item 0 42

    [[ ${M_ITEMS[0]} = '42' ]]
}
@test "push_item/second" {
    M_ITEMS=('1')

    push_item 0 2

    [[ ${M_ITEMS[0]} = '1, 2' ]]
}
@test "push_item/third" {
    M_ITEMS=('1, 2')

    push_item 0 3

    [[ ${M_ITEMS[0]} = '1, 2, 3' ]]
}

@test "play_round/1" {
    parse_input <test_input
    play_rounds 1

    declare -p M_ITEMS
    [[ ${M_ITEMS[0]} = '20, 23, 27, 26' ]]
    [[ ${M_ITEMS[1]} = '2080, 25, 167, 207, 401, 1046' ]]
    [[ ${M_ITEMS[2]} = '' ]]
    [[ ${M_ITEMS[3]} = '' ]]
}

@test "M_INSPECTED_COUNTS after 20 rounds" {
    parse_input <test_input
    play_rounds 20

    declare -p M_INSPECTED_COUNTS
    [[ ${M_INSPECTED_COUNTS[0]} = 101 ]]
    [[ ${M_INSPECTED_COUNTS[1]} = 95 ]]
    [[ ${M_INSPECTED_COUNTS[2]} = 7 ]]
    [[ ${M_INSPECTED_COUNTS[3]} = 105 ]]
}
