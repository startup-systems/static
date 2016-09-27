#!/bin/bash

set -ex


function html() {
    TITLE="$(head -n 1 "$1")"
    BODY="$(tail -n +2 "$1")"
    FILENAME=$(sed 's/txt/html/g' <<< "$1")
    # Paragraph formatting
    BODY=$(sed ':a;N;$!ba;s/^\n/<p>/g' <<< "$BODY")
    BODY=$(sed ':a;N;$!ba;s/\n\+/<\/p><p>/g' <<< "$BODY")
    BODY=$(sed 's/$/<\/p>/g' <<< "$BODY")
    # URL formatting
    BODY=$(sed 's/\(https\?[^ <]*.com\(\/[^ <\.]*\)\?\)/<a href="\1">\1<\/a>/g' <<< "$BODY")
    # Save html
    sed -e "s@{{title}}@$TITLE@g; s@{{body}}@$BODY@g" "$(pwd)"/template.html > "$FILENAME"
}
export -f html

# Remove previous output folder
rm -rf "$2"
# Copy txt files for exact (sub)folder structure
mkdir -p "$2"
cp -R "$1" "$2"
# Do the HTML conversion
find "$2" -type f -exec bash -c 'html "$0"' {} \;
# Remove old .txt files in output folder
find "$2" -type f -name "*.txt" -print0 | xargs -0 rm
