#!/bin/bash
# ./generate.sh examples/simple/ output/
set -ex

# YOUR CODE HERE
input_dir=$1
output_dir=$2
mkdir -p "$output_dir" # if not exist


for f in "$input_dir"/*
do
	title=$(head -n1 "$f")
	body=$(tail -n1 "$f")

	# html=$(echo "$html" | sed "s/{{body}}/$body/")


	f="${f%.*}".html # wihout extension
	# touch "$f"
	sed -e 's/{{title}}/'"$title"'/g' -e 's/{{body}}/'"$body"'/g' template.html > "$f"
	# sed -e 's/{{title}}/'"$title"'/g' -e 's/{{body}}/'"$body"'/g' template.html > "$f"

done
