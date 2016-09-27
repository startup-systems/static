#!/bin/bash

set -ex

if [ -d "$1" ]; then
  if [ ! -d "$2" ]; then
    mkdir -pv "$2"    
  fi



for file in "$1"/*.txt
  do

    title="$(head -n 1 "$file")"

    body="$(tail -n 1 "$file")"

    base="$(basename "$file" .txt)"

    sed 's/{{title}}/'"$title"'/g;s/{{body}}/'"$body"'/g' template.html >> "$2"'/'"$base"'.html'
    done
fi
