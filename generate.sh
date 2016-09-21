#!/bin/bash

set -ex

# YOUR CODE HERE
if [ ! -d "$2" ]; then
	mkdir -p "$2"
fi
# not sure if there's a output path

files=($("ls" "$1"))
#for input_file in "$1"/*.txt;do
for input_file in "${files[@]}"
do 
	input_file_name=$(basename "$input_file")
	input_file_name=${input_file_name%.*} #strip off the extension
	title=$(head -n 1 "$1"/"$input_file")
	body=$(tail -n 1 "$1"/"$input_file")
	cat template.html > "$2"/"$input_file_name.html"
	sed -i "s/{{body}}/$body/g" "$2"/"$input_file_name.html"
    	sed -i "s/{{title}}/$title/g" "$2"/"$input_file_name.html"
done

	
