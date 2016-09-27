#!/bin/bash

set -ex

# Remove previous output folder
rm -rf "$2"
# Copy txt files for exact (sub)folder structure
mkdir -p "$2"
# Do the HTML conversion
for FILE in $1/*.txt; do
    TITLE="$(head -n 1 "$FILE")"
    BODY="$(tail -n +2 "$FILE")"
    FILENAME="$(basename "$FILE" .txt).html"
    # Paragraph formatting
    BODY=$(sed ':a;N;$!ba;s/^\n/<p>/g' <<< "$BODY")
    BODY=$(sed ':a;N;$!ba;s/\n\+/<\/p><p>/g' <<< "$BODY")
    BODY=$(sed 's/$/<\/p>/g' <<< "$BODY")
    # URL formatting
    BODY=$(sed 's/\(https\?[^ <]*.com\(\/[^ <\.]*\)\?\)/<a href="\1">\1<\/a>/g' <<< "$BODY")
    # Save html
    sed -e "s@{{title}}@$TITLE@g; s@{{body}}@$BODY@g" "template.html" > "$2"/"$FILENAME"
done
