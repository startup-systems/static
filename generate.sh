#!/bin/bash

set -ex

# YOUR CODE HERE
# Any arguments appear as "$1", "$2", "$3" and so on. 
input = $1
output = $2

if [ ! -d $output ]; then
  mkdir -p output
fi


for filename in "input"/*
do
  #get rid of txt
  filename = $(basename "filename" .txt)
  htmlname = $filename.html
  titlesub = $(head -1 "$filename")
  bodysub = $(tail -1 "$filename")
  sed -e 's/{{title}}/'"$titlesub"'/g' -e 's#{{body}}#'"$bodysub"'#g' template.html > "$output/$htmlfile"


done
