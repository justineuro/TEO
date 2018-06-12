#!/bin/bash
###
# Filename: makeQuotesN.sh  
# Description: Bash script for generating within double quotes and in a single line, 
# a set of N expressions.  Input is a multiple of N expressions, one expression per
# line of input.
# Usage: ./makeQuotesN.sh N <filename.txt>
# 	where N is the number of expressions per set and <filename.txt> is the input file.
# Created:	11.06.2018 19:06:27
# Revised:	2018.06.11 19:35:25 +8
### 
#----------------------------------------------------------------------------------
# create output file adding quotes; 
# if output file already exists, then make a back-up copy
#----------------------------------------------------------------------------------
N=$1
filen=${2/.txt/.csv}
if [ -f $filen ]; then 
	mv $filen $filen."bak"
fi

i=1
while read currLn
do
	echo ${currLn}
	if [ "$((i % N))" == "0" ]; then
	echo -e "\t\"${currLn}\"" >> $filen
	else
		echo -en "\"${currLn}\"" >> $filen
	fi
	i=$[i + 1]
done < $2
#
##
###
