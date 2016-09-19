#!/bin/bash
set -ex
base=`pwd`
outdir=$2
if [ ! -d "$outdir" ]; then
	mkdir ./$outdir
fi

cd $1
files=(`ls .`)
numFiles=${#files[@]}

cd $outdir
for ((i=0; i< $numFiles; i++)); do
	cat $base/template.html > $outdir/post${i}.html
	subtopic=`head -n 1 $base/$1/${files[i-1]}`
	subbody=`tail -n 1 $base/$1/${files[i-1]}`
	sed -i "s/{{title}}/$subtopic/g" post${i}.html
	sed -i "s/{{body}}/$subbody/g" post${i}.html
done

