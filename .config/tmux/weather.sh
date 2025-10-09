#!/usr/bin/env bash

# change city to yours
CITY="City"
RESULT=$(curl --silent https://wttr.in/${CITY}?format="%c+%t" | xargs)

# Deal with some strange possible outcomes
if [[ $RESULT == Unknow* ]]; then
    echo "n/a"
elif [[ $RESULT == \<!DOCTYPE* ]]; then
    echo "n/a"
elif [[ $RESULT == Sorr* ]]; then
    echo "n/a"
elif [[ $RESULT == This* ]]; then
    echo "n/a"
else
    echo "$RESULT"
fi
