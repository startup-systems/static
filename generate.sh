#!/bin/bash

#./generate.sh inputdir outputdir

set -ex
inputdir=$1
outputdir=$2
made_directory=$3 #if not directory exists, need to make one

if [! -d "$outputdir"]; then #first check if directory exists, if not, need to make one
	mkdir -p "$made_directory"
fi 
for file in "$inputdir"/*.txt; do #for a file in inputdir, 
	filename="$(basename "$file" ".txt")" #rename with basename and make sure is a text file
	head=$(head -1 "$file") #isolating title
	tail=$(tail -n +3 "$file") #isolating body
	sed 's/{{title}}/$head/' template.html > filename
	for filename in "$inputdir"/*.txt; do
		sed 's/{{body}}/$tail/' "$newfile" > "$outputdir/$filename.html" 
	done
done 