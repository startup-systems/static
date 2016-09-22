#!/bin/bash
# ./generate.sh examples/simple/ output/
# set -ex

# YOUR CODE HERE
input_dir=$1
output_dir=$2
if [ ! -d "$output_dir" ]; then
	mkdir -p "$output_dir"
fi


for f in "$input_dir"/*
do
	title=$(head -n1 "$f")
	body=$(tail -n3 "$f")

	# html=$(echo "$html" | sed "s/{{body}}/$body/")

	f_name=$(basename "$f" .txt).html # without path
	# f_name="${f%.*}".html # wihout extension
	# f_name="$output_dir$f_name" # attch output path
	# sed -e 's/{{title}}/"$title"/g' 's/{{body}}/'"$body"'/g' template.html > "$f"
	# sed "s@{{title}}@$title@g;s@{{body}}@$body@g" template.html > "$output_dir$f_name"
	sed -e 's/{{title}}/'"$title"'/' -e 's/{{body}}/'"$body"'/' template.html >> "$output_dir$f_name"
done



