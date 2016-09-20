#!/bin/bash

set -ex

dir_in="$1/*"
dir_out="$2"


if [ ! -d "$dir_out" ]; then
	mkdir -p "$dir_out"
fi

function wt_head(){
	echo -e "<!DOCTYPE html>
<html>
  	<head>
    	<meta charset="utf-8">"
}


function wt_title(){
		echo -e "<title>"
		sed -n '1'p ${file_in}
		echo -e "</title>"
	
}

function wt_body(){
	echo -e "	</head>
 	<body>"
  	sed -n '3,$'p ${file_in}
}

function wt_end(){
	echo -e "	</body>
</html>"
}


function convert(){
	for file_in in $dir_in; do 
	filename="$(basename "$file_in" .txt)"
	echo $filename
	wt_head > "$dir_out/$filename.html"
	wt_title >> "$dir_out/$filename.html"
	wt_body >> "$dir_out/$filename.html"
	wt_end >> "$dir_out/$filename.html"	
done
}

convert

# YOUR CODE HERE
