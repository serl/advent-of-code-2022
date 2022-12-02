#!/usr/bin/env bash

WIN_SCORE=6
DRAW_SCORE=3
LOSE_SCORE=0
ROCK_SCORE=1
PAPER_SCORE=2
SCISSORS_SCORE=3

play_round() {
    local round="$1"
    outcome_score=$(outcome_score "$round")
    shape_score=$(shape_score "$round")
    echo $((shape_score + outcome_score))
}

outcome_score() {
    case $* in
    *Z)
        echo $WIN_SCORE
        return
        ;;
    *Y)
        echo $DRAW_SCORE
        return
        ;;
    *X)
        echo $LOSE_SCORE
        return
        ;;
    esac
}

shape_score() {
    case "$*" in
    A*) # rock
        case "$*" in
        *X) # lose
            echo $SCISSORS_SCORE
            return
            ;;
        *Y) # draw
            echo $ROCK_SCORE
            return
            ;;
        *Z) # win
            echo $PAPER_SCORE
            return
            ;;
        esac
        ;;
    B*) # paper
        case "$*" in
        *X) # lose
            echo $ROCK_SCORE
            return
            ;;
        *Y) # draw
            echo $PAPER_SCORE
            return
            ;;
        *Z) # win
            echo $SCISSORS_SCORE
            return
            ;;
        esac
        ;;
    C*) # scissors
        case "$*" in
        *X) # lose
            echo $PAPER_SCORE
            return
            ;;
        *Y) # draw
            echo $SCISSORS_SCORE
            return
            ;;
        *Z) # win
            echo $ROCK_SCORE
            return
            ;;
        esac
        ;;
    esac
}

total=0
while IFS=$'\n' read -r line; do
    current=$(play_round "$line")
    total=$((total + current))
done

echo "The total score is $total"
