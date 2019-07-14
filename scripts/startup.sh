#!/usr/bin/env bash

idle() {
	if ! pgrep -x "$1" > /dev/null && type "$1" &> /dev/null; then
		true
	else
		false
	fi
}

idle unclutter && unclutter &
idle compton && compton -b
idle blugon && unclutter &
