setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source common.sh
}

@test "compare/example 1" {
    compare '1,1,3,1,1' '1,1,5,1,1'
}
@test "compare/example 2" {
    compare '[[1],[2,3,4]]' '[[1],4]'
}
@test "compare/example 3" {
    ! compare '[9]' '[[8,7,6]]'
}
@test "compare/example 4" {
    compare '[[4,4],4,4]' '[[4,4],4,4,4]'
}
@test "compare/example 5" {
    ! compare '[7,7,7,7]' '[7,7,7]'
}
@test "compare/example 6" {
    compare '[]' '[3]'
}
@test "compare/example 7" {
    ! compare '[[[]]]' '[[]]'
}
@test "compare/example 8" {
    ! compare '[1,[2,[3,[4,[5,6,7]]]],8,9]' '[1,[2,[3,[4,[5,6,0]]]],8,9]'
}

@test "unpack_list/simple" {
    output="$(unpack_list [1,2,3])"
    echo "output=$output"
    [[ $output = '1,2,3' ]]
}
@test "unpack_list/nested" {
    output="$(unpack_list [1,[[2],3]])"
    echo "output=$output"
    [[ $output = '1,[[2],3]' ]]
}

@test "pop_element/simple" {
    list="1,2,3"
    pop_element list
    echo "ITEM=$ITEM list=$list"
    [[ $ITEM = "1" ]]
    [[ $list = "2,3" ]]
}
@test "pop_element/sublist" {
    list="[1,5,6],2,[3,8]"
    pop_element list
    echo "ITEM=$ITEM list=$list"
    [[ $ITEM = "[1,5,6]" ]]
    [[ $list = "2,[3,8]" ]]
}
@test "pop_element/last" {
    list="42"
    pop_element list
    echo "ITEM=$ITEM list=$list"
    [[ $ITEM = "42" ]]
    [[ $list = "" ]]
}
@test "pop_element/empty" {
    list=""
    ! pop_element list
}
