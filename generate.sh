#!/bin/bash
input_dir=$1
output_dir=$2
mkdir -p "$output_dir"
  
for file in $input_dir/*.txt
do
	title="$(head -n 1 "$file")"
	body="$(tail -n +3 "$file")"
	filename="$(basename "$file" .txt)".html
	sed 's#{{title}}#'"$title"'#g;s#{{body}}#'"$body"'#g' template.html > "$output_dir"/"$filename"
done
