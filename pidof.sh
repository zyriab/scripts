#!/bin/bash

### Usage: pidport 3003
pidport() {
    if [ -z "$1" ]; then
        echo "Usage: pidport PORT_NUMBER"
        return 
    fi

    lsof -n -i :$1 | grep LISTEN
}
