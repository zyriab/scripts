#!/bin/bash

THIS="$(readlink -f ${BASH_SOURCE:-$0})"
DIR_PATH="$(dirname $THIS)"

source "$DIR_PATH/pidof.sh"
source "$DIR_PATH/yazi-wrapper.sh"
