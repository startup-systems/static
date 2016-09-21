#!/bin/bash

set -ex

if [ ! -d "$2" ]; then 
	mkdir -p "$2"
fi

input=$(ls "$1")
for file in $input
do
    title=$(head -n 1 "$1"/"$file")
	body=$(tail -n 1 "$1"/"$file")
	filename=$(basename "${file}")
	filename=${filename%.*}
	cat template.html > "$2/$filename.html"
	sed -i "s@{{body}}@$body@g" "$2/$filename.html"
	sed -i "s@{{title}}@$title@g" "$2/$filename.html"
done



