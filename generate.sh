#!/bin/bash

set -ex

INPUT_TXT=$1
OUTPUT_HTML=$2

if [[ ! -d ${"OUTPUT_HTML"} ]]; then
	mkdir -p $"OUTPUT_HTML"
fi

TITLE_R="{{title}}"
BODY_R="{{body}}"

for f in "$INPUT_TXT"/*
	do
		TITLE=$(head -1 "$f")
		fname=$(basename "$f")
		fbname=${fname%.*}
		BODY=$(tail -n 1 "$f")
		sed -e 's/'"$TITLE_R"'/'"$TITLE"'/' -e 's/'"$BODY_R"'/'"$BODY"'/' template.html > $"OUTPUT_HTML"/"$fbname".html
	done
