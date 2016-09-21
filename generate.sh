#!/bin/bash

set -ex

# YOUR CODE HERE
# Any arguments appear as "$1", "$2", "$3" 

input="$1"
output=$2

if [ ! -d "$output" ]; then
  mkdir -p "$output"
fi


for file in "$input"/*
do
  fname=$(basename "$file" .txt)
  newfile=$fname.html
  titlesub=$(head -1 "$file")
  bodysub=$(tail -n 1 "$file")

  sed -e 's/{{title}}/'"$titlesub"'/g' -e 's#{{body}}#'"$bodysub"'#g' template.html > "$outdir/$newfile"
done


