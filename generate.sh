#!/bin/bash

set -ex

# YOUR CODE HERE
input=$1
output="$2"
if [ ! -d "$output" ]; then
   mkdir -p "$output"
fi

for file in $input*
do
  name=$(basename "$file"| cut -d. -f1)
  title=$(head -n1 "$file")
  body=$(tail -n+3 "$file")
  outputname="$output/$name.html"
  sed -e 's/{{title}}/'"$title"'/g' -e 's#{{body}}#'"$body"'#g' template.html > "$outputname"
done
