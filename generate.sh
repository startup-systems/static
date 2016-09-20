#!/bin/bash

set -ex

inputdir=$1/*
outputdir=$2
if [ ! -d "$outputdir" ]; then
    mkdir -p $outputdir
fi

template=~/static/template.html
for i in $inputdir; do
    lines=$(sed -n $= $i)
    title=$(head -1 $i)
    body=$(tail -n $(($lines-2)) $i)
    
    oldfilename=$(basename $i)
    newfilename=$(echo $oldfilename | sed s/txt/html/)

    sed "s/{{title}}/$title/g" $template > $outputdir/$newfilename
    sed -i "s/{{body}}/$body/g" $outputdir/$newfilename
    
    #extra credit
	
done

