#!/bin/bash

set -ex

# YOUR CODE HERE
# get the first and second arguments
input="$1"
output=$2
# make directory if it does not exist
if [ ! -d "$output" ]; then
  mkdir -p "$output"
fi
# apply basename to create new filename
for file in "$input"/*
do
  oldname=$(basename "$file" .txt)
  newname=$oldname.html
  title=$(head -n 1 "$file")
  body=$(tail -n 1 "$file")
# replace title and body, then output the file
  sed -e 's/{{title}}/'"$title"'/g' -e 's#{{body}}#'"$body"'#g' template.html > "$output/$newname"
done
