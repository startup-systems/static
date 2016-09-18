#!/bin/bash

set -ex

# YOUR CODE HERE
mkdir $2
python3 generate.py $1 $2
