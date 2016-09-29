#!/bin/bash

set -ex

#make directory
mkdir -p "$outputD"

#set input
input=$1

#set output
output=$2

#adjust name
for filename in "$1"/*;
	do
		name=$(basename "$file".txt | cut -d -f1)
		output="$file".txt
		title=$(head -n 1 "$filename")
		body=$(tail -n+3 "$filename")
		sed -e 's/{{title}}/'"$title"'/' -e 's/{{body}}/'"$body"'/' template.html >> "$2"/"$file.html"
done
