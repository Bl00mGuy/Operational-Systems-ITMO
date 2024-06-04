#!/bin/bash

dir=/root/lab4/dop
file_path=$1
command=$2
interactive=$3

if [ ! -d "$dir/as_git" ];
then
    mkdir $dir/as_git
fi

case $command in
    "check")
        if [ -f "$dir/as_git/$file_path" ];
        then
            diff $file_path $dir/as_git/$file_path > $dir/$file_path.log
            if [ "$interactive" = "-i" ];
            then
                diff $file_path $dir/as_git/$file_path
            fi
        else
            cp $file_path $dir/as_git/$file_path
        fi
        ;;
    "recover")
        rm $file_path
        ln $dir/as_git/$file_path $file_path
        ;;
    "add")
        if [ ! -f "$dir/as_git/$file_path" ] || ! cmp -s "$file_path" "$dir/as_git/$file_path";
        then
            cp $file_path $dir/as_git/$file_path
        fi
        ;;
    *)
        echo "Unknown command: $command"
        ;;
esac