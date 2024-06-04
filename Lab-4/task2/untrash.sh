#!/bin/bash

source_dir=/root/lab4/task1
restore_dir=/root/lab4/task2

trash_dir="$source_dir/.trash"
trash_log="$source_dir/.trash.log"
home_dir="restore_dir"

check_name() {
        if [ ! "`echo $1 | sed 's/[a-z,0-9,_,-,.]*//'`" == "" ];
        then
                echo "Incorrect input"
                exit 1
        fi
}

if [[ $# > 1 ]];
then
        echo "Too many arguments"
        exit 1
fi

if [[ $# < 1 ]];
then
        echo "Too few arguments"
        exit 1
fi

if [[ ! -d $trash_dir ]];
then
        echo "Directory not found"
        exit 1
fi

if [[ ! -f $trash_log ]];
then
        echo "Log file not found"
        exit 1
fi

file=$1
check_name $file

a=""
num=""
for i in $(grep "$1" $trash_log | awk '{print $1}');
do
        a=$(echo $i | sed -e 's,'"$source_dir"'/,,')
        if [ $a == $file ];
        then
                break;
        fi
done

if [ $a == $file ];
        then
                echo "File found in trash!"
        else
                echo "File not found in trash!"
                exit 1
fi

total_files=$(grep "$1" $trash_log | wc -l)
counter=0
restored_files=0

for i in $(grep "$1" $trash_log | awk '{print $NF}');
do
        counter=$((counter+1))
        full_path=$(grep $i $trash_log | awk '{$NF=""; print $0}')
        full_path=$(echo "$full_path" | sed 's/ *$//')
        echo "File $counter out of $total_files: $full_path"
        read -p "Do you want to restore this file? [Y/N] " ans
        case "$ans" in
                "y" | "Y")
                        new_file_name=""
                        trash_name=$i
                        file_name_no_path=$(echo "$full_path" | awk 'BEGIN{FS="/"}; {print $NF}')
                        previous_names="$file_name_no_path"
                        if [[ -f "${home_dir}/${file_name_no_path}" ]];
                        then
                                while true;
                                do
                                    read -p "File \"${home_dir}/${file_name_no_path}\"  already exists. Enter a new name: " new_file_name
                                        check_name $new_file_name
                                        if [[ -f "${home_dir}/${new_file_name}" ]];
                                        then
                                                previous_names="$previous_names, $new_file_name"
                                                echo "The names $previous_names are taken. Please try another one."
                                        else
                                                break
                                        fi
                                done
                                ln "${trash_dir}/${trash_name}" "${home_dir}/${new_file_name}"
                                rm "${trash_dir}/${trash_name}"
                        else
                                ln "${trash_dir}/${trash_name}" "${home_dir}/${file_name_no_path}"
                                rm "${trash_dir}/${trash_name}"
                        fi
                        sed "/${i}/d" $trash_log > .trash.log2 && mv .trash.log2 $trash_log
                        restored_files=$((restored_files+1))
                        continue
                ;;
                "n"|"N")
                        if [ $counter -eq $total_files ];
                        then
                                if [ $restored_files -eq 0 ];
                                then
                                        echo "Failed to restore the desired file"
                                else
                                        echo "Successfully restored $restored_files file(s)"
                                fi
                        fi
                        continue
                ;;
        esac
done