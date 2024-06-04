#!/bin/bash

if [ -f /var/log/anaconda/syslog ]; then
    awk '$2 == "INFO"' /var/log/anaconda/syslog > info.log
else
    echo "file /var/log/anaconda/syslog not found."
fi
