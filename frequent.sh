#!/bin/bash

# Print the n most frequent words
# usage: frequent.sh <n> <file>
# example: frequent.sh 10 file.vtt

max=$1
shift

cat $@ | tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq -c | sort -rn | head -n $max
