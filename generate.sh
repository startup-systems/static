#!/bin/bash

set -ex


READ_FOLDER=$1
WRITE_FOLDER=$2
rm -rf $WRITE_FOLDER
mkdir -p $WRITE_FOLDER

for file in $READ_FOLDER/*.txt
do
	t=`head -n 1 $file`							#Extract title
	b=`tail -n +3 $file`						#Extract body
	name=`basename $file .txt`					#Extract file name
	sed "s/{{title}}/$t/g;s/{{body}}/$b/g" template.html > $WRITE_FOLDER/$name.html
done
