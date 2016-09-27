#!/bin/bash

set -ex

#set input
input=$1

#set output
output=$2

#check for directory
if [ ! -d "$directory" ]; then
	mkdir -p $2
fi

#pathname for the file
name=$(basename "$file".txt | cut -d -f1)

#adjust name
for filename in $1/*.txt
	do
		title=$(head -n 1 "$file")
		body=$(tail -n + 3 "$file")
		sed -e 's/{{title}}/'"$title"'/ -e 's/{{body}}/'"$body"''/template.html > "$output".html	
