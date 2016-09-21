#!/bin/bash

set -ex

# YOUR CODE HERE
echo "This script converts any file into a html file."
mkdir -p "$2"
#cd "$2"
output=$(cd "$2"; pwd)
#cd -
#cd "$1"
input=$(cd "$1"; pwd)
#cd - 

find "$inputdir" -name "*.txt" > temp.txt

while IFS='' read -r filename || [[ -n "$filename" ]]; do
	bname=$(basename "$filename")
	title=$(head -n1 "$filename")
	body=$(tail -n +3 "$filename")
	sed -e "s/{{title}}/$title/" -e "s/{{body}}/$body/" < "template.html" > "$output/${bname%.txt}.html"
done < temp.txt