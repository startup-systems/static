#!/bin/bash

set -ex

# YOUR CODE HERE
echo "This script converts any file into a html file."
mkdir -p "$2"
cd "$2"
outputdir=$(pwd)
cd -
cd "$1"
 
inputdir=$(pwd)
cd - 

find "$inputdir" -name "*.txt" > temp_file_list.txt

while IFS='' read -r filename || [[ -n "$filename" ]]; do
	bname=$(basename "$filename")
	title=$(head -n1 "$filename")
	body=$(tail -n +3 "$filename")
	sed -e "s/{{title}}/$title/" -e "s/{{body}}/$body/" < "template.html" > "$outputdir/${bname%.txt}.html"
done < temp_file_list.txt
