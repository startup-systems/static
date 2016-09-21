#!/bin/bash

set -ex

inputPath=$1
outputPath=$2

if [ ! -d "$outputPath" ];then
  mkdir -p "$outputPath"
fi

for file in "$inputPath"/* ; do
  fileName=$(basename "$file" .txt)
  fileName="${fileName%.*}"
  outputName="$fileName.html"
  title=$(head -n 1 "$file")
  body=$(tail -n+3 "$file")
  sed -e 's/{{title}}/'"$title"'/' -e 's/{{body}}/'"$body"'/' template.html >> "$outputPath"/"$outputName"
done