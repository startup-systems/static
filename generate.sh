#!/bin/bash

set -ex

# YOUR CODE HERE
input="$1"
if [ ! -d "$2" ]
then
        mkdir -p "$2"
fi
for file in "$input"/*
do
        title=$(head -n 1 "$file")
        body=$(tail -n 1 "$file")
filename=$(basename "$file" .txt).html
sed  -e 's/{{title}}/'"$title"'/g' -e 's#{{body}}#'"$body"'#g' template.html > "$2/$filename"
done

