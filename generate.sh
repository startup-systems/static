#!/bin/bash
set -ex

# YOUR CODE HERE
##set file location to be 1st input argument
inputdir=$1/*
## take 2nd argument as the output direcotry
outputdir=$2

##check if the output directory is exists or not, and make one if not
if [ ! -d "$outputdir" ]; then
  mkdir $outputdir
fi

##loop through the files in input directory

for file in $inputdir
do
  ##get the file name, strip out the prefix
  filename=$(basename "$file" .txt)
  newfile=$filename.html
  titlesub=$(head -1 $file)
  bodysub=$(tail -1 $file)
  sed -e 's/{{title}}/'"$titlesub"'/g' -e 's/{{body}}/'"$bodysub"'/g' template.html > $outputdir/$newfile
done
