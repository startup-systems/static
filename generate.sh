#!/bin/bash

set -ex

# YOUR CODE HERE
INPUT_DIRECTORY=$1
OUTPUT_DIRECTORY=$2

#function to inject title and body into html template
populate_template() {
        title=$1
        body=$2
        html_template_filename="./template.html"
        html_template=$(cat $html_template_filename)
        html_with_title=$(sed -e "s/{{title}}/${title}/g" <<< "$html_template")
        html=$(sed -e "s/{{body}}/${body}/g" <<< "$html_with_title")
        echo "$html"
}

# Prepare the output directory
if [ -d "$OUTPUT_DIRECTORY" ]; then
  # Control will enter here if $DIRECTORY exists.
        echo "Removing files from output directory"
        rm -rf "${OUTPUT_DIRECTORY:?}"/*
else
        echo "Making output directory $OUTPUT_DIRECTORY"
        mkdir -p "$OUTPUT_DIRECTORY"
fi

# Iterate over the example articles
for txt_filepath in $INPUT_DIRECTORY/*; do
        text=$(cat "$txt_filepath")
        title=$(echo "$text" | head -n 1)
        body=$(echo "$text" | tail -n +3)
	html=$(populate_template "$title" "$body")
        txt_filename=$(basename "$txt_filepath")
        html_filename=$(sed -e "s/txt/html/g" <<< "$txt_filename")
        html_filepath=$OUTPUT_DIRECTORY'/'$html_filename
        echo "$html" | tee -a "$html_filepath"
done
