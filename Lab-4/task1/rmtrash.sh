#!/bin/bash

dir=/root/lab4/task1
filename_regex='^[^\n/]+$'

if [[ $# > 1 ]]; then
    echo "Too many arguments"
    exit 1
fi

if [[ $# < 1 ]]; then
    echo "Too few arguments"
    exit 1
fi

if [[ ! $1 =~ $filename_regex ]]; then
    echo "Invalid file name"
    exit 1
fi

if [[ ! -f "$dir/$1" ]]; then
    echo "File not found"
    exit 1
fi

if [[ ! -e "$dir/.trash" ]]; then
    mkdir "$dir/.trash"
fi

value=1
while [[ -e "$dir/.trash/$1$value" ]]; do
    value=$((value + 1))
done