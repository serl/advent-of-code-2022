setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_sum_smaller_directories.sh </dev/null >/dev/null
}

@test "output on test_input" {
    output=$(./1_sum_smaller_directories.sh <test_input | tail -1)
    [ "$output" = 95437 ]
}

@test "output" {
    output=$(./1_sum_smaller_directories.sh <input | tail -1)
    [ "$output" = 1307902 ]
}

@test "cd /" {
    [[ $(cd_command '' /) = '' ]]
}
@test "cd x first level" {
    [[ $(cd_command '/' x) = /x ]]
}
@test "cd .." {
    [[ $(cd_command '/a/b/c' ..) = /a/b ]]
}
@test "cd x deep down" {
    [[ $(cd_command '/a/b/c' x) = /a/b/c/x ]]
}

@test "calculate_directory_sizes" {
    declare -A DIRECTORIES
    declare -A FILES=(
        ["/d/d.ext"]="5626152"
        ["/d/d.log"]="8033020"
        ["/c.dat"]="8504156"
        ["/a/h.lst"]="62596"
        ["/d/k"]="7214296"
        ["/d/j"]="4060174"
        ["/a/f"]="29116"
        ["/a/g"]="2557"
        ["/b.txt"]="14848514"
        ["/a/e/i"]="584"
    )

    calculate_directory_sizes

    [[ ${DIRECTORIES["/"]} = "48381165" ]]
    [[ ${DIRECTORIES["/a/e"]} = "584" ]]
    [[ ${DIRECTORIES["/a"]} = "94853" ]]
    [[ ${DIRECTORIES["/d"]} = "24933642" ]]
}
