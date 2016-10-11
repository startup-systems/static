#!/bin/bash

#./generate.sh inputdir outputdir

set -ex
inputdir=$1
outputdir=$2 

for file in "$inputdir"/*.txt; do #for a file in inputdir, 
	fileTitle="$(head -n 1 "$file")" #isolate title
	fileBody="$(tail -n +3 "$file")" #isolate body
	sed "s/{{title}}/$fileTitle/g" "template.html" | sed "s/{{body}}/$fileBody/g" > "$outputdir"/"$("basename" "$file" ".txt")".html
	done 
