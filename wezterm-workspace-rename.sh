#!/bin/bash

function wrn() {
    if [ -n "$1" ]; then
        wezterm cli rename-workspace "$1"
    else
        echo "Usage: wrn <name>"
    fi
}
