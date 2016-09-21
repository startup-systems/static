#!/bin/bash

set -ex

# YOUR CODE HERE
file_input="$1"
file_output="$2"
if [ ! -d "$file_output" ]; then
        mkdir -p "$file_output"
fi

for file in "$file_input"/*.txt
do
        html_n=$(basename "$file" .txt)
        Head=$(head -n 1 "$file")
        Tail=$(tail -n 3 "$file")
        sed -e 's#{{title}}#"$Head"#' -e 's#{{body}}#"$Tail"#' template.html > "$file_output"/"$html_n".html
done
