#!/bin/bash

set -ex
base=`pwd`
outdir=$2
if [ ! -d $outdir ]
then
	mkdir -p $outdir
fi

files=(`ls $1`)
num=${#files[@]}

for i in "${files[@]}"
do
	NAME=`echo "$i" | cut -d'.' -f1`
	echo $NAME
	cat template.html > "$2/$NAME.html"
	subtopic=`head -n 1 $1/$i`
	subbody=`tail -n 1 $1/$i`
	sed -i "s!{{title}}!$subtopic!g" $2/$NAME.html
	sed -i "s!{{body}}!$subbody!g" $2/$NAME.html
done


