#!/bin/bash

set -ex

inPath="$1"
outPath="$2"
mkdir -p "$2"

# YOUR CODE HERE
for file in $inPath/*.txt; do
#
        filename="$(basename $file)"
        outfilename="$(echo $filename | cut -f 1 -d '.')"
        out="$outPath/$outfilename".html
        sed -e "s/{{title}}/$(head -n 1 $inPath/$filename)/g" -e "s/{{body}}/$(tail -n +3 $inPath/$filename)/g" template.html > "$out"
done    


