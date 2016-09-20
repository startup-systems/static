#!/bin/bash
for file in "$1"/*
do
subfile=$(basename $file .txt)
htmlfile=$subfile.html

mytitle=$(head -n 1 $file)
mybody=$(tail -n+3 $file)

sed -e 's/{{title}}/'"$mytitle"'/' -e 's/{{body}}/'"$mybody"'/' template.html >> $2/$htmlfile

done
