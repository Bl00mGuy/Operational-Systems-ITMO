#!/bin/bash

if [ "${PWD}" == "${HOME}" ]; then
    echo "path to home directory: $HOME"
    exit 0
else
    echo "Error: the script is not running from the home directory"
    exit 1
fi
