#!/bin/bash

set -ex

# YOUR CODE H
mkdir -p $2
for file in $1/* ; do
	echo item: $file
	filename=$(basename "$file" .txt) 
	title=$(head -1 $file) 
	body=$(tail -n +3 $file)
	cp template.html $2/$filename.html
	cat $2/$filename.html | sed -i "s/{{title}}/$title/g" $2/$filename.html
	cat $2/$filename.html | sed -i "s/{{body}}/$body/g" $2/$filename.html
done
