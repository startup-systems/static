#!/bin/bash

#set -ex
mkdir -p "$2"
for file in "$1"/*;
do
  line=$(head -n 1 $file)
  count=$(sed -n '$=' $file)
  counts=$((count - 1))
  main=$(head -n $count $file | tail -n $counts)
  main=`echo $main | tr '\n' "\\n"`
  fname=$(basename $file .txt)
  echo ""> $fname.html
  cp template.html $2/$fname.html
  sed -i "s/{{title}}/$line/g" $2/$fname.html
  sed -i "s/{{body}}/$main/g" $2/$fname.html
  cat $fname.html
done
