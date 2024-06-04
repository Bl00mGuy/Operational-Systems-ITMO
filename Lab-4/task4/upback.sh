#!/bin/bash

backup_path=/root/lab4/task3/backups
target_path=/root/lab4/task4/test

last_backup_date=$(ls $backup_path | grep -E "^Backup-" | sort -n | tail -1 | sed 's/^Backup-//')
last_backup="$backup_path/Backup-${last_backup_date}"

if [[ -z "$last_backup_date" ]];
then
        echo "Backup not found"
        exit 1
fi

if [[ ! -d $target_path ]];
then
        mkdir $target_path
fi

for fi in $(ls $last_backup | grep -Ev "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$");
do
        if [[ ! -f "$target_path/${fi}" ]] || [[ $(diff "$last_backup/${fi}" "$target_path/${fi}") != "" ]];
        then
                cp "${last_backup}/${fi}" "$target_path/${fi}"
                echo "File ${fi} successfully restored!"
        fi
done