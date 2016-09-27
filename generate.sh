#!/bin/bash

set -ex

# YOUR CODE HERE
SRC_DIR=$1
DES_DIR=$2

if [ ! -x "$DES_DIR" ];then
    mkdir -p "$DES_DIR"
fi

for f in "$SRC_DIR"/*
do
    if [ -f "$f" ];then
        # line_count=$(cat $SRC_DIR/$f |wc -l)

        title=$(head -1 "$f")
        lines=$(tail -n 1 "$f" | tr "\n" "\r")
        # if [ $line_count -ne 2 ]; then
        #     lines=`tail -$(($line_count - 2)) $SRC_DIR/$f | tr "\n" "\r"`
        # else
        #     lines=""
        # fi

        # tmplt=`cat ./template.html | sed "s/{{title}}/$title/"`
        # echo $tmplt

        # for line in `tail -$(($line_count - 2)) $SRC_DIR/$f`; do
        #     echo "==="
        #     echo $tmplt
        #     tmplt=`echo -e $tmplt | sed "s/{{body}}/$line\n{{body}}/"`
        #     echo $tmplt
        # done

        # echo "***"
        # echo $tmplt

        # echo -e $tmplt | sed "s/{{body}}/""/"  > $DES_DIR/$f.html

        DEST_FILE=$(basename "$f")
        # cat ./template.html | sed "s/{{title}}/$title/; s/{{body}}/$lines/" < ./template.html | tr "\r" "\n" > "$DES_DIR"/"${DEST_FILE%.*}".html
        sed "s/{{title}}/$title/; s/{{body}}/$lines/" < ./template.html | tr "\r" "\n" > "$DES_DIR"/"${DEST_FILE%.*}".html
    fi
done

