#!/bin/bash

set -ex

#make directory
mkdir -p $2

#set input
input="$1"

#set output
output="$2"

#pathname for the file
name=$(basename "$file".txt | cut -d -f1)

#adjust name
for filename in $1/*.txt
	do
		title="$(head -n 1 "$file")"
		body="$(tail -n + 3 "$file")"
		sed -e 's/{{title}}/'"$title"'/ -e 's/{{body}}/'"$body"''/template.html > $2/"$output"