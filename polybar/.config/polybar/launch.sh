#!/usr/bin/env bash

# Terminate running instances
killall -q polybar

# Wait for termination
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar(s)
barname="status"
command="polybar"

if [ -n "$1" ] && [ -e "$1" ]; then 
	command="$command -c $1"
fi

if [ "$command" != "polybar" ] || [ -e "$POLYBARCONFIGDIR/config" ]; then
	command="$command --reload"

	for m in $(polybar --list-monitors | cut -d":" -f1); do
		MONITOR=$m $command $barname &
	done

	echo "Bars Launched..."
else
	echo "error --> config not found"
fi
