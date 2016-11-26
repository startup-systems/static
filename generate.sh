#!/bin/bash

set -ex

indir=$1
outdir=$2

mkdir -p "$outdir"

for filename in $indir/*
   do
      title="$(head -n 1 "$filename")"
      filebody="$(tail -n +3 "$filename")"
      txtname="$(basename "$filename" .txt)"
      sed 's#{{title}}#'"$title"'#g;s#{{body}}#'"$filebody"'#g' template.html > "$outdir/$txtname".html

   done
