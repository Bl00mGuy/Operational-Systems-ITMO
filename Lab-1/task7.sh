#!/bin/bash

touch emails.lst

grep -rIhoE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' /etc | tr '\n' ',' | sed 's/,$/\n/' > emails.lst
