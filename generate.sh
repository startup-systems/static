#!/bin/bash

set -ex
input=$1
lastchar="${input: -1}"
if [ "$lastchar" != "/" ]
   then 
       input="$input/"
fi

for file in $input*
do
     
    fbname=$(basename "$file"| cut -d. -f1)
    output=$2
    mkdir -p "$output"
    lastchar="${output: -1}"
    if [ "$lastchar" != "/" ]
	then 
           output="$output/"
    fi
    title=$(head --lines=1 "$file")
    body=$(tail --lines=1 "$file")
    sed "s/{{title}}/$title/g" template.html > temp.html
    sed "s/{{body}}/$body/g" temp.html > "$output$fbname".html
done
rm temp.html
