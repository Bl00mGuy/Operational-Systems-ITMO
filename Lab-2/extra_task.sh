#!/bin/bash

get_sleeping_processes() {
        ps -eo pid,user,time,ni,state,args --sort=start_time | awk '$4 ~ /S/ && $3 >= "00:01:00" {print $1,$2}'
}

get_top3_low_nice_processes() {
        ps -eo pid,user,time,ni,state,args --sort=ni | awk 'NR <= 4 {print $1,$2,$3,$4,$5,$6}'
}

echo "#Список спящих процессов, работающих больше минуты:"
get_sleeping_processes

echo "#Топ 3 процессов с наименьшим показателем nice, работающих больше минуты:"
get_top3_low_nice_processes