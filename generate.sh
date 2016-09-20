#!/bin/bash

set -ex

# YOUR CODE HERE
file_output=$2
if [ ! -d "$file_output" ]; then
mkdir -p "$file_output"
fi

file_input="$1/*"

for files in $file_input
do
title=$(head -n 1 $files)
content=$(tail -n +3 $files)
output_name=$(basename "$files" .txt).html
sed -e 's/{{title}}/'"$title"'/g' -e 's#{{body}}#'"$content"'#g' template.html > "$2/$output_name"
done
