#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "requires you to enter 3 arguments you have entered $*"
    exit 1
fi

max=$1

for i in "$@"; do
    if [ "$i" -gt "$max" ]; then
        max=$i
    fi
done

echo "Max is $max"
