#!/bin/bash

set -e

DEST=$2

echo "DEST: $DEST"

for i in $(seq 0 9); do
  cat > "$DEST/post$i.html" <<- HTML
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Post $i Title</title>
</head>
<body>
This is the body of Post $i.
</body>
</html>
HTML
done
