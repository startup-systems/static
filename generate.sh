#!/bin/bash

#set -x #print commands
set -e #exit upon errors
echo "[Running the script..]"
for input_file in "$1"/*;do
	echo "<$input_file>"
	output_file=$(basename "$input_file")
	echo "$output_file" 

	title=$(cat "$input_file" | sed -n '1p')
	#echo "$title"
	body=$(cat "$input_file" | sed -n 2~1p | sed -e 'i <p>' -e 'a </p>')
	#echo "$body"


	echo "<!DOCTYPE html>
	<html>
  	<head>
    		<meta charset="utf-8">
    		<title>$title</title>
  	</head>
  	<body>
    		$body
  	</body>
	</html>">>"./$output_file.html"
done

