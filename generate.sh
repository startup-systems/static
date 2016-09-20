#!/bin/bash

set -ex

if [ -d "$1" ]; then
  if [ ! -d "$2" ]; then
    mkdir -pv $2    
  fi



for file in "$1"/*.txt
  do

    title="$(cat "$file" | head -n 1)"

    body="$(cat "$file" | tail -n 1)"

    base="$(basename "$file" .txt)"

    sed "s/{{title}}/$title/g;s/{{body}}/$body/g" template.html >> $2/$base.html
    done
fi
