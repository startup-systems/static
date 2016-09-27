#!/bin/bash


set -ex

dir_in="$1/*"
dir_out="$2"

if [ ! -d "$dir_out" ]; then
	mkdir -p "$dir_out"
fi

function wt_file(){
	echo -e "<!DOCTYPE html>"
	echo -e "<html>"
	echo -e "	<head>"
  	echo -e "		<meta charset=\"utf-8\">"   	
	echo -e "		<title>"
	sed -n '1p' "${file_in}"
	echo -e "		</title>"	
	echo -e "	</head>"
 	echo -e "	<body>"
  	sed -n '3,$p' "${file_in}"
	echo -e "	</body>"
	echo -e "</html>"
}


function convert(){
	for file_in in $dir_in; do 
	filename="$(basename "$file_in" .txt)"
	wt_file > "$dir_out/$filename.html"	

done

}

convert

# YOUR CODE HERE
