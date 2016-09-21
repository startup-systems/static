#!/bin/bash

#./generate.sh inputdir outputdir

set -ex
inputdir=$1
outputdirectory=$2

for file in `ls $inputdir/*.txt`; do
	head=$(head -1 $file) #isolating title
	tail=$(tail -n +3 $file) #isolating body
	sed 's/{{title}}/$head/' template.html > $outputdir filename=$(basename "$fullfilename")
	for filename in $outputdir; do
		sed 's/{{body}}/$tail/' $filename > $finalfile
	done
done


