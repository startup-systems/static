#!/bin/bash

set -ex

if [ -d "$1" ]; then
  mkdir -p "$2"    
  for i in "$1"/*.txt; do
    title=$(head -n 1 "$i")
    body=$(tail -n 1 "$i")
    outputName=$(basename "$i" | sed "s/txt/html/g")
    sed -e "s/{{title}}/$title/" -e "s/{{body}}/$body/" < "template.html" > "$2/$outputName"
    done
fi