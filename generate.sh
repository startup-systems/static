#!/bin/bash

set -ex

input_dir=$1
output_dir=$2

# if file does not exist, create one
if [ ! -d "$output_dir" ];then
mkdir -p "$output_dir"
fi

for file in "$input_dir"/* ; do
file_name=$(basename "$file" .txt)
file_name="${file_name%.*}"
output_name="$file_name.html"
title=$(head -n 1 "$file")
body=$(tail -n+3 "$file")
sed -e 's/{{title}}/'"$title"'/' -e 's/{{body}}/'"$body"'/' template.html >> "$output_dir"/"$output_name"
done