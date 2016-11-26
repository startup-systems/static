#!/bin/bash

# Luis Serota
# Startup Systems and Engineering Fall 2016
# generate.sh

# recursively creates folder structure for output
mkdir -p $2

# Iterate over all the files
for f in $1/*.txt
do
title=$(head -n 1 $f) # Grabs the first line of the file, sets as title var
body=$(tail -n +3 $f | tr '\n' '\t') # Grabs the rest of file starting from 3rd line, set as body var
							# Swap all newlines for tabs for use of sed

# Create and write to the files using the template, inserting $title and $body vars where necessary
cat template.html | sed "s/{{title}}/$title/g" | sed "s|{{body}}|$body|" | tr '\t' '\n' > $2/$(basename $f .txt).html
done
