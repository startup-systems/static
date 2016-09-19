#!/bin/bash

set -e
inputDirectory=$1;
outputDirectory=$2;

# create output directory if doesn't exist
if [[ ! -d $outputDirectory ]]; then
  mkdir -p $outputDirectory;
fi

# loop through input directory
for file in $inputDirectory/*.txt; do
  # convert extension to html
  fileName="$(basename ${file%.*})".html;

  # extract title and body
  title=$(head -n 1 $file);
  body=$(tail -n +3 $file);

  # copy template to corresponding html file
  cat template.html > "$outputDirectory/$fileName";

  # replace title and body in template appropriately
  sed -i -e "s,{{title}},$title,g" "$outputDirectory/$fileName";
  sed -i -e "s,{{body}},$body,g" "$outputDirectory/$fileName";

done
# YOUR CODE HERE
