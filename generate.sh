#!/bin/bash

set -ex

# YOUR CODE HERE

if [ ! -d $2 ]
	then
	mkdir $2
fi

for post in $1/*
do

    html="$(basename "$post" .txt).html"

    titleField="$(head -n 1 "$post")"
    bodyText="$(tail -n 1 "$post")"
    
    echo "$post" | sed -e 's/{{body}}/'"$bodyText"'/' -e 's/{{title}}/'"$titleField"'/' template.html >> "$2/$html"

done