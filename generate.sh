#!/bin/bash

set -ex
input=$1
output=$2
# YOUR CODE HERE
if [ ! -d "$output" ]
then
        mkdir -p "$output"
fi

for i in "$input"/*.txt
do
        filename="$(basename "$i" ".txt")"
	title=$(head -n 1 "$i")
	echo filename
        body=$(tail -n +3 "$i")
        sed -e "s/{{title}}/""$title""/g" -e "s#{{body}}#""$body""#g" <"template.html"> "$output/$filename.html"      
done
