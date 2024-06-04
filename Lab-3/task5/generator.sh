#!/bin/bash

while true;
do
        read line
        echo "$line" > pipe

        if [[ "$line" == "QUIT" ]];
        then
                echo "Program execution finished!"
                exit 0
        fi

        if [[ "$line" != "+" && "$line" != "*" && "$line" != [0-9] ]];
        then
                echo "Error input command: generator"
                exit 1
        fi
done