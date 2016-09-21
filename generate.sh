#!/bin/bash

set -ex

# YOUR CODE HERE

#for file in $1/*.txt;
indir=$1
outdir=$2
#check if directory exists (chttp://stackoverflow.com/questions/59838/check-if-a-directory-exists-in-a-shel#l-script)
if [ ! -d "$outdir" ]; then
 mkdir "$outdir"
fi

for file in "$indir"/*
do
  filename=$(basename "${file}")
  filename=${filename%.*}

  title=$(head -1 "$file")  
  body=$(tail -1  "$file")

# cat template.html > "$outdir/${filename}.html"#why did this not work????

  sed -e 's/{{title}}/'"$title"'/' -e 's/{{body}}/'"$body"'/'  template.html >> "${outdir}/${filename}.html"  

done



