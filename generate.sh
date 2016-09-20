#!/bin/bash

#set -ex

# YOUR CODE HERE
SRC=$1
DST=$2
mkdir "$DST"

for filename in $SRC/*.txt
do
	tmp=`basename $filename .txt`
	output="$DST"/"$tmp".html 
	sed "s/{{title}}/$(head -1 "$filename")/;s/{{body}}/$(tail -n 1 "$filename")/" <./template.html > "$output"
done 