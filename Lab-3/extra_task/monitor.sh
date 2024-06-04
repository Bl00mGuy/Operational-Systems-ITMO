#!/bin/bash

logfile="status.log"
count=0

handle_term() {
        echo "Я погиб"
        exit 1
}

trap 'handle_term' SIGTERM

while true; do
        echo "Я в порядке"
        ((count++))

        echo "Я в порядке" >> "$logfile"

        if [ "$count" -ge 10 ]; then
                echo "Лог файл достиг максимального размера. Отправляю сигнал остановки."
                kill -SIGTERM $$
        fi

        sleep 1
done