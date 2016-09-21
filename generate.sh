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

	f=$(basename "$f")
	f="${f%.*}".html # wihout extension
	f="$output_dir$f"
	touch "$f"
	# sed -e 's/{{title}}/"$title"/g' 's/{{body}}/'"$body"'/g' template.html > "$f"
	content=$(sed "s@{{title}}@$title@g;s@{{body}}@$body@g" template.html)
	echo "$content" > "$f"

done
