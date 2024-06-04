#!/bin/bash

str=""
while true; do
  read -p "Enter a string (enter 'q' to exit): " line
  
  if [[ "$line" == "q" ]]; then
    break
  fi
  
  str="$str$line"
done

echo "You entered: $str"
