#!/bin/bash

#set -ex

# YOUR CODE HERE
# MYVAR="/var/cpanel/users/joebloggs:DNS9=domain.com" 
# NAME=${MYVAR%:*}  # retain the part before the colon
# NAME=${NAME##*/}  # retain the part after the last slash
# echo $NAME


if [ "$3" ]; then
    echo "Too many arguments... "
    echo "Aborting operation" 
    echo "---- Usage Help ----"
    echo "COMMAND  input-dir  out-dir"
    exit 1  		
fi


if [ "$1" ] && [ "$2" ]; then
	
    #Check if input directory exists
    if [ -d "$1" ]; then
	echo "Parsing files in: $1"
    else
    	echo "$1 does not exist!"
	echo "Aborting operation!"
	exit 1
    fi

   #Filepath  ending check
   # case "$2" in
   #     */)
   #        echo "has slash"
   #     ;;
   #     *)
   #        echo "doesn't have a slash"
   #     ;;
   #esac
		
		
    echo "Creating output directory: $2"
    mkdir -pv "$2"		


    for file in "$1"/*.txt
    do
	echo "parsing  ${file##*/}"
	fname=${file##*/}
	fname=${fname%.*}
	fname="$fname".html

	#Create HTML files
	echo "-- creating $fname"
	touch "$2"/"$fname"


	# Extract title and body
        title="$(head -n 1 "$file")" 
        body="$(tail -n +3 "$file")"

	#Copy content	
	#cp template.html "$2"/"$fname"
	sed  "s/{{title}}/$title/g"  template.html > "$2"/"$fname".temp
	sed  "s/{{body}}/$body/g"   "$2"/"$fname".temp  >  "$2"/"$fname"
		
    done
	rm "$2"/*.temp
	echo "--------------------------"
	echo "HTML generation completed!"
 	echo "--------------------------"
else
    echo "Arguments misssing... "
    echo "Aborting operation!"	
    exit 1
fi
    
    
