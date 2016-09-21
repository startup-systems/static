#!/bin/bash

set -ex

# YOUR CODE HERE
anyfile=$1
opt1=$2

if [! -d "$opt1"]; then
  mkdir -p "$opt1"
fi

for file in "$1"/*
do
  newfname=$(basename $file .txt)
  newf=$newfname.html
  cat template.html > "$2/$newf"
  title=$(head -n 1 $file)
  body=$(tail -n 1 $file)
  sed -e 's/{{title}}/${title}/g' -e "s#{{body}}#${body}#g" $2/$newf 
done
