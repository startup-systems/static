#!/bin/bash

set -ex

# YOUR CODE HERE
echo "This script converts any file into a html file."
directory=$(pwd)
mkdir -p $2
cd $2
outputdir=$(pwd)
echo $outputdir
cd -
cd $1 
inputdir=$(pwd)
cd - 

find "$inputdir" -name "*.txt" > temp_file_list.txt

while IFS='' read -r filename || [[ -n "$filename" ]]; do
	echo $filename
	bname=$(basename "$filename")
	title=$(head -n1 "$filename")
	body=$(tail -n +3 "$filename")
	echo $title 
	echo $body
	sed -e "s/{{title}}/$title/" -e "s/{{body}}/$body/" < "template.html" > "$outputdir/${bname%.txt}.html"
done < temp_file_list.txt
