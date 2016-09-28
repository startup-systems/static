#!/bin/bash

set -ex

# set variables
INPUT_SOURCE=$1
OUTPUT_DESTINATION=$2

# recursively creates folder structure for output
mkdir -p "$OUTPUT_DESTINATION"

# loop through files ending in .txt in new output folder structure
for file in $INPUT_SOURCE/*.txt
do
	# grab first line of file
	postTitle="$(head -n 1 "$file")"
	

	# grab rest of file, replacing new lines with \a character
	postBody="$(tail -n +3 "$file" | tr "\n" "\a")"

	# swap for extra credit
	# postBodyEdited="$(tail -n +3 "$file" | tr "\n" "\a")"
	# regex for html
	# https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)
	# i tried
	
	# insert template contents (use sed to swap out title and body, then tr to swap out \a's with new lines)
	sed "s/{{title}}/$postTitle/g" "template.html" | sed "s|{{body}}|$postBody|" | tr "\a" "\n" > $OUTPUT_DESTINATION/$(basename $file .txt).html
done

