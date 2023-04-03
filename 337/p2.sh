#Tony Lin
#tolllin
#113283910

#!/bin/bash

# Two arguments must be provided
if [ $# -ne 2 ]; then
    echo "USAGE: $0 <data_file> <output_file>"
    exit 1
fi

# Get arguments
data_file=$1
output_file=$2

# Check if data_file exists and is a regular file
if [ ! -f "$data_file" ]; then
    echo "$data_file not found"
    exit 1
fi

# Create the output file if it does not exist
if [ ! -f "$output_file" ]; then
    touch "$output_file"
fi

# Read each line of the data file
while read line; do 
    # PRECONDITION: Formatted as 2:3,3;4 
    # IFS will convert line into an array of nums that correspond to each column 
    IFS=";,:"
    column=1

    # Each num corresponds to a column
    for num in $line; do
        # Increment the num of columns by 1
        column=$((column+1))

        # Output file already starts with "Col 1 :"  
        if grep -q "^Col $column :" "$output_file"; then
            # Get previous sum and add the new num to it
            prev_sum=$(grep "^Col $column :" "$output_file" | cut -d" " -f4)
            new_sum=$((prev_sum+num))
            # Write the new sum to the output file
            sed -i "s/^Col $column : $prev_sum\$/Col $column : $new_sum/" "$output_file"
        else
            # Append a new line to the output file
            echo "Col $column : $num" >> "$output_file"
        fi
    done
done < "$data_file"