#!/bin/bash

set -ex

inPath="$1"
outPath="$2"

mkdir -p "$2"

# YOUR CODE HERE
for file in $inPath/*.txt; do
#
        filename=$(basename "$file")
        outfilename=$(echo "$filename" | cut -f 1 -d '.')
        out="$outPath/$outfilename".html
        title="$(head -n 1 $inPath/$filename)"
	body="$(tail -n +3 $inPath/$filename)"
	sed -e s/{{title}}/"$title"/g -e s/{{body}}/"$body"/g template.html > "$out"
done    


