#!/bin/bash

set -ex

# YOUR CODE HERE
# get the first and second arguments
input_dir="$1"
output_dir=$2
# make directory if it does not exist
if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir"
fi
# apply basename to create new filename
for file in "$input_dir"/*
do
  oldname=$(basename "$file" .txt)
  newname=$oldname.html
# define title/body by getting first line
  title=$(head -n 1 "$file")
  body=$(tail -n 1 "$file")
# replace title and body, then output the file
  sed -e 's/{{title}}/'"$title"'/g' -e 's#{{body}}#'"$body"'#g' template.html > "$output_dir/$newname"
done
