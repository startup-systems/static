#!/bin/bash

#set -ex

# YOUR CODE HERE
if [ $# -lt 2 ]
then
  echo "Expecting two arguments"
  exit 1
fi

src=$1
destination=$2

if [ ! -d "$src" ]
then
  echo "Directory $src not found"
  exit 1
fi

if [ ! -d "$destination" ]
then
  mkdir "$destination"
fi

listfiles=$( ls "$src" )
for i in $listfiles
do
  name=$( basename "$i" .txt )
  title=$( head -n 1 "$src/$i" )
  content=$( tail -n +3 "$src/$i" )
  sed "s/{{title}}/$title/g" < ./template.html | sed "s/{{body}}/$content/g" >> "$destination/$name.html"

done

exit 0
