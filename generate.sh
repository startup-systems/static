#!/bin/bash

set -ex

# YOUR CODE HERE
indir="$1*"
outdir=$2

if [ ! -d "$outdir" ]; then
  mkdir -p "$outdir"
fi


for file in $indir
do
  filename=$(basename "$file" .txt)
  newfile=$filename.html
  titlesub=$(head -1 "$file")
  bodysub=$(tail -n 1 "$file")

  sed -e 's/{{title}}/'"$titlesub"'/g' -e 's#{{body}}#'"$bodysub"'#g' template.html > "$outdir/$newfile"
done
