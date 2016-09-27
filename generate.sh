#!/bin/bash
set -ex

# 1st input argument = file location
input_directory="$1"

# 2nd input argument = output directory
output_directory=$2

# if output directory does not exist, create one
if [ ! -d "$output_directory" ]; then
  mkdir -p "$output_directory"
fi

# loop through all files
for file in $input_directory/*.txt; do
    # define title
    title="$(head -n 1 "$file")"
    # define body
    body="$(tail -n 1 "$file")"
    # define output file name
    output="$(basename "$file" .txt).html"
    # text replacement with sed that is going to output file with >
    sed -e 's#{{body}}#'"$body"'#g' -e 's#{{title}}#'"$title"'#g' "template.html" > "$output_directory"/"$output"
done