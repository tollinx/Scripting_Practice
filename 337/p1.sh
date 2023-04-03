#Tony Lin
#tolllin
#113283910

#!/bin/bash

# $1 = extension name like ".py"
# $2 = source directory name
# $3 = destiantion directory name 

# Check if we have 3 arguments
if [ $# -ne 3 ]; then 
    echo "USAGE: p1.sh <extension> <src_dir> <dst_dir>" 
    exit 1
fi


# Check if the source directory exists
if [ ! -d "$2" ]; then
  echo "Source directory doesn't exist"
  exit 1
fi

echo "We have 3 args and src directory exists"

#enclosed variables in "" might mess up stuff?  
if [ ! -d "$3" ]; then
    #p means to create parent directories for the dest directory
    mkdir -p "$3"
fi
 
files_found=$(find "$2" -name "*$1");
    # what does each file in files_found look like?
    for file in $files_found; do
        # echo ${file}

        # removes the first directory/source directory
        # Replaces it with the destination directory
        destination=$3/${file#$2/*} 

        # Removes the filename part of the directory to get destination directory
        destination=${destination%/*}

        #CASE: Directory already exists
        #Move the file to the directory
        if [ -d "$destination" ]; then
            mv $file "$destination"
        else
        #CASE: Directory doesn't exist yet
        # Create new directory with all necessary parent directories, then moves it
            mkdir -p "$destination"
            mv $file "$destination"
        fi
    done

#echo "Success!"

