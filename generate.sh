 if [ ! -d "$2" ];then
 	mkdir -p "$2"
 fi
 
 for file in "$1"/*
 do
 	fname=$(basename "$file" .txt).html
 
 	title=$(head -n1 "$file")
 	body=$(tail -n1 "$file")
 
 	sed -e 's/{{title}}/'"$title"'/' -e 's/{{body}}/'"$body"'/' template.html >> "$2/$fname"
 done
