#!/bin/bash

set -ex

# YOUR CODE HERE

mkdir -p "$2"

for post in $1/*
do

    html="$(basename "$post" .txt).html"

    titleField="$(head -n 1 "$post")"
    bodyText="$(tail -n 1 "$post")"
    
    cat template.html | sed -e 's/{{body}}/'"$bodyText"'/' -e 's/{{title}}/'"$titleField"'/' >> "$2/$html"

done