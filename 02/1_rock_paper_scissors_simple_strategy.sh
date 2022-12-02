#!/usr/bin/env bash

WIN_SCORE=6
DRAW_SCORE=3
LOSE_SCORE=0
ROCK_SCORE=1
PAPER_SCORE=2
SCISSORS_SCORE=3

play_round() {
    local round="$1"
    shape_score=$(shape_score "$round")
    outcome_score=$(outcome_score "$round")
    echo $((shape_score + outcome_score))
}

shape_score() {
    case "$*" in
    *X)
        echo $ROCK_SCORE
        return
        ;;
    *Y)
        echo $PAPER_SCORE
        return
        ;;
    *Z)
        echo $SCISSORS_SCORE
        return
        ;;
    esac
}

outcome_score() {
    case "$*" in
    A*) # rock
        case "$*" in
        *X) # rock
            echo $DRAW_SCORE
            return
            ;;
        *Y) # paper
            echo $WIN_SCORE
            return
            ;;
        *Z) # scissors
            echo $LOSE_SCORE
            return
            ;;
        esac
        ;;
    B*) # paper
        case "$*" in
        *X) # rock
            echo $LOSE_SCORE
            return
            ;;
        *Y) # paper
            echo $DRAW_SCORE
            return
            ;;
        *Z) # scissors
            echo $WIN_SCORE
            return
            ;;
        esac
        ;;
    C*) # scissors
        case "$*" in
        *X) # rock
            echo $WIN_SCORE
            return
            ;;
        *Y) # paper
            echo $LOSE_SCORE
            return
            ;;
        *Z) # scissors
            echo $DRAW_SCORE
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
