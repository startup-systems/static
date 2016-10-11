#!/bin/bash

#set -ex

with open('some-other-post.txt', 'r') as inputfile:
    title = inputfile.readline().strip()
    next(inputfile)
    for line in inputfile:
    	body = line.strip()
    inputfile.close()

outputfile = open('practice.html', 'w')

def convert_to_html(inputfile, outputfile):
	print "<!DOCTYPE html>"
	print "<html>"
	print "  <head>"
	print "    <meta charset=" + "utf-8" + ">"
	print "    <title>"+ title +"</title>"
	print "  </head>"
	print "<body>"
	print "    " + body
	print "  </body>"
	print "</html>"

print convert_to_html(inputfile, outputfile)


printf "<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>"
    echo $head "</title>
  </head>
  <body>"
    echo $tail 
    printf "</body>
</html>"

