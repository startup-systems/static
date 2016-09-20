#!/bin/bash

set -ex

# YOUR CODE HERE
file_output=$2
if [ ! -d "$file_output" ] 
then
  mkdir -p "$file_output"
fi

file_input="$1"

for files in "$file_input"/*
do
  output_name=$(basename "$files" .txt)
  new_name=$output_name.html
  title=$(head -1 $files)
  content=$(tail -n 1 $files)
  sed -e 's/{{title}}/'"$title"'/g' -e 's#{{body}}#'"$content"'#g' template.html > "$file_output/$new_name"
done
