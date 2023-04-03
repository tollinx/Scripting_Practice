#Tony Lin
#tolllin
#113283910

#!/bin/bash

#CASE: Need two arguments
if [ "$#" -ne 2 ]; then
  echo "input file and dictionary missing"
  exit 1
fi

#CASE: Invalid input file 
if [ ! -f "$1" ]; then
  echo ""$1" is not a file"
  exit 1
fi

#CASE: Invalid dict file 
if [ ! -f "$2" ]; then
  echo ""$2" is not a file"
  exit 1
fi

#Printing out all mismatched words:

# 1st pipe part: Finds all words that don't match the dictionary
# i gives case insensitivity, o gets the word instead of entire line, w matches only whole words, v inverts all matches, and f reads patterns from second file

# 2nd pipe part: Filters out non-5 letter words. o gets ONLY the incorect words from each line 
grep -iwovf "$2" "$1" | egrep -o "\b[a-z]{5}\b"
