#!/bin/bash

while true; do
  echo "menu:"
  echo "1. nano"
  echo "2. vi"
  echo "3. links"
  echo "4. exit"
  echo -n "Enter menu option "
  
  read option
  
  case $option in
    1) nano ;;
    2) vi ;;
    3) links ;;
    4) break ;;
    *) echo "incorrect input"
  esac
done
