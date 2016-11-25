#!/bin/bash

set -ex

SOURCE_DIR=$1;
DEST_DIR=$2;

# mimic structure of SOURCE_DIR and mutate .txt into .html
# all the while we need to read title and body into <title> and <body>
# first line title and second body
# use template.html in current dir to write new content into place

# ec: 
# replace all urls into links
# any blank lines followed by more content should create a new paragraph

rm -rf "$DEST_DIR";
mkdir -p "$DEST_DIR";

# for each file in SOURCE_DIR lets read title and body and use txt_to_html() to generate files
for file in "$SOURCE_DIR"/*; do
    filename=$(basename "$file" .txt);
    
    title=$(sed -n '1p' "$file");
    body=$(sed -n '3, $p' "$file");

    sed -e "s/{{title}}/$title/" < template.html > tmpfile;
    sed -e "s/{{body}}/$body/" < tmpfile > "$DEST_DIR"/$filename.html;
    rm tmpfile;
done
