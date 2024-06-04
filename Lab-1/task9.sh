#!/bin/bash

find /var/log/ -name "*.log" -exec wc -l {} \; | awk '{ total += $1 } END { print total }'
