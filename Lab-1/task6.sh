#!/bin/bash


if [ -f /var/log/anaconda/X.log ]; then
    grep '(WW)' /var/log/anaconda/X.log | sed 's/(WW)/Warning:/g' > full.log
    grep '(II)' /var/log/anaconda/X.log | sed 's/(II)/Information:/g' >> full.log

    cat full.log
else
    echo "file /var/log/anaconda/X.log not found."
fi
