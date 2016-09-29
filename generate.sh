#!/bin/bash

set -ex

#makeDir
if [ ! -d "$output" ]; 
	then
	mkdir -p "$output"
fi

#set input
input=$1

#set output
output=$2

#adjust name and create file
for filename in "$input"/*;
	do
		name=$(basename "$filename".txt | cut -d -f1)
		outputF="$name.html"
		title=$(head -n 1 "$filename")
		body=$(tail -n+3 "$filename")
		sed -e 's/{{title}}/'"$title"'/' -e 's/{{body}}/'"$body"'/' template.html >> "$output"/"$outputF"
done
