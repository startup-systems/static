#!/bin/bash

set -ex

# YOUR CODE HERE
SRC=$1
DST=$2

if [ ! -d "$DST" ]; then
	mkdir -p "$DST"
fi

for filename in "$SRC"/*.txt
do
	tmp="$(basename "$filename" .txt)"
	output="$DST"/"$tmp".html 
	sed -e "s#{{title}}#$(head -1 "$filename")#;s#{{body}}#$(tail -n 1 "$filename")#" ./template.html > "$output"
done