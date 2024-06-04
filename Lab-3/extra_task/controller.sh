#!/bin/bash

./monitor.sh &

wait $!

echo "Скрипт monitor.sh завершил свою работу."