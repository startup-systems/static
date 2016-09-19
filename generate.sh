#!/bin/bash
set -ex

# YOUR CODE HERE

tempfile=template.html

indir=$1
outdir=$2

if [ ! -d "$outdir" ]; then
  mkdir $outdir
fi

for file in $indir/*
do
  fname=$(basename "$file" .txt)
  newfile=$fname.html
  txttitle=$(head -1 $file)
  txtbody=$(tail -1 $file)
  sed -e 's/{{title}}/'"$txttitle"'/g' -e 's/{{body}}/'"$txtbody"'/g' $tempfile > $outdir/$newfile
done
