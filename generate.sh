#!/bin/bash

#set -ex

if [ $# -lt 2 ] 
then
	echo "Invalid args. Two expected."
	exit 1
fi

input=$1
output=$2

if [ ! -d "$input" ]
then
	echo "Input directory does not exist."
	exit 1
fi


if [ ! -d "$output" ]
then
	mkdir -p "$output"
fi

files=$( ls "$input" )
for f in $files
do
	fbasename=$( basename "$f" | cut -d. -f1)
	ftype='.html'
	name=$fbasename$ftype
	title=$( head --lines=1 "$input/$f" )
	body=$( tail --lines=1 "$input/$f")
	sed "s/{{title}}/$title/g" template.html > temp.html
	sed "s/{{body}}/$body/g" temp.html > "$output/$name"
done
 
