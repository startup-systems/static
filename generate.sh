#!/bin/bash

set -ex

# assign variables from command line args

output_dir=$2
input_path=$1

# check if directory exists (from https://stackoverflow.com/questions/59838/check-if-a-directory-exists-in-a-shell-script)
if [ ! -d "$output_dir" ]; then
  mkdir -p $output_dir
fi

# for each text file in input directory
for file in "$input_path"*.txt
do
	title=$(head -n 1 $file)
	body=$(tail -n +3 $file)

	filename=$(basename -s ".txt" $file) # strip file name of directory and extension

	#create the output file
	touch "$output_dir/$filename.html"
	cat template.html >> "$output_dir/$filename.html"

	#now, make substitutions into file (syntax for sed taken from https://unix.stackexchange.com/questions/159367/using-sed-to-find-and-replace
	sed -i -e "s/{{title}}/$title/g" "$output_dir/$filename.html"
	sed -i -e "s/{{body}}/$body/g" "$output_dir/$filename.html"
done
