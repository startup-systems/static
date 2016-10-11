#!/bin/bash
set -ex

#set input
input=$1

#set output
output=$2

#makeDir
if [ ! -d "$output" ];
	then mkdir -p "$output"
fi


#adjust name and create file
for filename in $input/*.txt;
	do
		filE="$(basename "${filename%.*}")".html;
		#title
		title=$(head -n 1 "$filename");
		#body
		body=$(tail -n+3 "$filename");
		
		#cat template
		cat template.html > "$output/$filE";

		#replace
		sed -i -e "s,{{title}}, $title,g" "$output/$filE";
		sed -i -e "s,{{body}}, $body,g" "$output/$filE";
done
