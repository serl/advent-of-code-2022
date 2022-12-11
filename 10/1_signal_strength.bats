setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")"
}
setup() {
    source 1_signal_strength.sh </dev/null >/dev/null
    parse_input <test_input
}

@test "output on test_input" {
    output=$(./1_signal_strength.sh <test_input | tail -1)
    echo "output=$output"
    [[ $output = 13140 ]]
}

@test "output" {
    [[ $CI ]] || skip "Running on CI only"
    output=$(./1_signal_strength.sh <input | tail -1)
    echo "output=$output"
    [[ $output = 14540 ]]
}

@test "signal_strenght/20" {
    [[ $(signal_strenght 20) = 420 ]]
}

@test "signal_strenght/60" {
    [[ $(signal_strenght 60) = 1140 ]]
}

@test "signal_strenght/100" {
    [[ $(signal_strenght 100) = 1800 ]]
}

@test "signal_strenght/140" {
    [[ $(signal_strenght 140) = 2940 ]]
}

@test "signal_strenght/180" {
    [[ $(signal_strenght 180) = 2880 ]]
}

@test "signal_strenght/220" {
    [[ $(signal_strenght 220) = 3960 ]]
}
