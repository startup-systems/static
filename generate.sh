#!/bin/bash

# YOUR CODE HERE
# Luis Serota - Startup Systems and Engineering
# September 2016
# generate.sh

# Die on failures
set -e

# Make the new directory (recursively)
mkdir -p $2

# Get the number of files in the directory
#count=$(find $1 -maxdepth 1 -type f|wc -l) #help from Hai Vu http://stackoverflow.com/questions/11131020/how-to-get-the-number-of-files-in-a-folder-as-a-variable

# Iterate over all the files
for file in $1*.txt
do
        name=${file##*/}
        base=${name%.txt}

       	newName=$base.html

       	# Go line by line through the file
        path=$1$name
        count=0
		while read p; do
			if [[ "$count" -eq "0" ]]; then
			 	title=$p
			fi
			if [[ "$count" -eq "2" ]]; then
				body=$p
			fi
			count=$((count+1))
		done < $path
		# Generate the new file
		newpath=$2$newName
		touch $newpath 

		echo $newpath
		# Write to the file
		cat template.html | sed "s/{{title}}/$title/g" | sed "s|{{body}}|$body|" | tr '\a' '\n' > $newpath
done