#!/bin/bash

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        echo "Changing directory to $cwd"
		cd "$cwd"
	fi
	rm -f -- "$tmp"
}
