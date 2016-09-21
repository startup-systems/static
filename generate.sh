#!/bin/bash

set -ex

# YOUR CODE HERE
inputfile=$1
outputfile=$2

mkdir -p $2
 
for file in "$1"/*.txt
do
	title=$( head -n 1 "$file")
	body=$( tail -n +3 "$file")
	f=$(basename "$file" .txt).html

	cp template.html "$2"/"$f"
	sed -i "s/{{title}}/$title/g" "$2"/"$f"
	sed -i "s/{{body}}/$body/g" "$2"/"$f" 

done
