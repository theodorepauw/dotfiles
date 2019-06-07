#!/bin/bash

IFS=$'\n' ## for effective cutting

# pacmd gives indices as index: n
inputs=($(pacmd list-sink-inputs | rg -F 'index:' | cut -f6 -d' '))

# sinknames are listed after device.description:
names=($(pacmd list-sinks | rg -F 'device.description' | cut -f2 -d'"'))

declare -a sinks=()

i=0
for sink in $(pacmd list-sinks | rg -F 'index:'); do
	sinks[i]=$(echo "$sink" | cut -f6 -d' ')
	[ "$(echo $sink | cut -f3 -d' ')" = '*' ] && currentindex="$i"
	((i++))
done

prevoutputname="${names[$currentindex]}"

if [ -n "$1" ]; then
	swapindex="$1"
else
	swapindex="$(((currentindex+1)%${#sinks[@]}))"
fi

if [ "$currentindex" != "$swapindex" ] && pacmd list-sinks | rg -qF "index: ${sinks[swapindex]}" ; then
	newoutputname="${names[$swapindex]}"
	
	pacmd set-default-sink ${sinks[swapindex]} &> /dev/null
	for i in "${inputs[@]}"; do pacmd move-sink-input "$i ${sinks[swapindex]}" &> /dev/null; done
	
	echo "Audio switched from $prevoutputname to $newoutputname"
	if type "notify-send" &> /dev/null; then
		notify-send "Audio switched from $prevoutputname to $newoutputname"
	fi
fi

