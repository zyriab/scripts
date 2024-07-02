#!/bin/bash

# The plugin will auto execute this zvm_after_select_vi_mode function
function zvm_after_select_vi_mode() {
  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
        set_cursor "block"
    ;;
    $ZVM_MODE_INSERT)
        set_cursor "line"
    ;;
    $ZVM_MODE_VISUAL)
        set_cursor "block"
    ;;
    $ZVM_MODE_VISUAL_LINE)
        set_cursor "block"
    ;;
    $ZVM_MODE_REPLACE)
        set_cursor "under"
    ;;
  esac
}

function set_cursor() {
    local block=$'\e[2 q'
    local line=$'\e[0 q'
    local under=$'\e[4 q'

    if [[ $1  == "block" ]]; then
        echo -ne $block
    elif [[ $1 == "under" ]]; then
        echo -ne $under
    else
        echo -ne $line
    fi
}
