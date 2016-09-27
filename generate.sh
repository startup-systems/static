#!/bin/bash

set -ex

# YOUR CODE HERE
mkdir -p "$2"

output=$(cd "$2"; pwd)
input=$(cd "$1"; pwd)

find "$input" -name "*.txt" > temp.txt

while IFS='' read -r filename || [[ -n "$filename" ]]; do
	bname=$(basename "$filename")
	title=$(head -n1 "$filename")
	body=$(tail -n +3 "$filename")
	sed -e "s/{{title}}/$title/" -e "s/{{body}}/$body/" < "template.html" > "$output/${bname%.txt}.html"
done < temp.txt