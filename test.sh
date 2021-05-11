#!/bin/sh

directory=$1
fileType="$2"
formatFile=`echo $2 | awk -F "." '{print $NF}'`
totalFile=`find $directory -type f -name \*.$formatFile | wc -l`
if [[ -z $directory || -z $fileType ]]
then
      echo test: missing operand
      echo "Try './test.sh <directory> <filetype>'"
elif [[ ! -d $directory ]]
then
      echo "test: cannot find '$directory' : no such directory"
elif [[ "$totalFile" == "0" ]] 
then
      echo "test: no such file or invalid filetype"
      echo "Try './test.sh <directory> *.pdf'"
else
      totalSize=`find $directory -type f -name \*.$formatFile -exec stat -c %s {} \; | awk '{sum+=$1}END{print sum}'`
      formatSize=`printf "%'d" $totalSize`

      echo There are $totalFile \*\.$formatFile files in $directory and its subdirectories.
      echo The total file size of the $totalFile \*\.$formatFile files is $formatSize bytes.
fi
