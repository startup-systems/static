#!/bin/bash

#set -x #print commands
set -e #exit upon errors
echo "[Running the script..]"
for input_file_path in "$1"/*;do
	echo "INPUT FILE PATH: $input_file_path"
	input_file_basename=$(basename "$input_file_path")
	echo "INPUT FILE BASENAME: $input_file_basename" 
	input_file_basename_without_extension=$(basename "$input_file_path" .txt)
	echo "INPT FILE BASENAME WITHOUT EXTENSION: $input_file_basename_without_extension"
	output_file_path=$2/$input_file_basename_without_extension.html

	echo "OUTPUT FILE PATH:$output_file_path"
	mkdir -p $2	
	touch $output_file_path
	
	title=$(cat "$input_file_path" | sed -n '1p')
	#echo "$title"
	body=$(cat "$input_file_path" | sed -n 2~1p | sed -e 'i <p>' -e 'a </p>')
	#echo "$body"


	echo "
<!DOCTYPE html>
<html>
 	<head>
  		<meta charset="utf-8">
    		<title>$title</title>
  	</head>
  	<body>
    		$body
  	</body>
</html>">"$output_file_path"
done

