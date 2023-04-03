#Tony Lin
#tolllin
#113283910

#!/bin/bash

# One arg must be provided 
if [ $# -ne 1 ]; then
  echo "score directory missing"
  exit 1
fi

# check if the scores directory is a valid directory
if [ ! -d "$1" ]; then
  echo "$1 is not a directory"
  exit 1
fi

# iterate over each file in the scores directory
for file in $1/*; do

  # Skip if its a directory
  if [ -d "$file" ]; then
    continue
  fi
  
  # NR==2 goes to the row with all the values
  # Each value/record is separated by delimiter comma
  read ID q1 q2 q3 q4 q5 <<< $(awk -F ',' 'NR==2{print $1,$2,$3,$4,$5,$6}' "$file")

  
  # Calculate overall grade using double arith
  percentage=$(echo "scale=2; ($q1 + $q2 + $q3 + $q4 + $q5)*10/5" | bc -l)
  
  # Assign grade to student
  if (( $(echo "$percentage >= 93.0" | bc -l) )); then
    grade="A"
  elif (( $(echo "$percentage >= 80.0" | bc -l) )); then
    grade="B"
  elif (( $(echo "$percentage >= 65.0" | bc -l) )); then
    grade="C"
  elif (( $(echo "$percentage >= 51.0" | bc -l) )); then
    grade="D"
  else
    grade="F"
  fi

#  echo "This student got "$percentage" and this grade: "$grade""
  echo "ID:"$ID":"$grade""
done


