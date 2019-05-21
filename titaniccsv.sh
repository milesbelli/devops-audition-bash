#!/bin/bash

# Reversed columns

numcols="$(csvtool width train.csv)"

bckcols=$numcols

while [ $bckcols -gt 0 ]
do
	if [ "$bckwrdsprnt" = "" ] 
	then
		bckwrdsprnt=$bckcols
	else
		bckwrdsprnt="$bckwrdsprnt,$bckcols"
	fi
		
	((bckcols--))
done

touch backwards.csv

csvtool col $bckwrdsprnt train.csv > backwards.csv


# Every other column

skipcols=1

while [ $skipcols -le $numcols ]
do
	if (($skipcols % 2 == 0))
	then
		if [ "$skipprnt" = "" ]
		then
			skipprnt=$skipcols
		else
			skipprnt="$skipprnt,$skipcols"
		fi
	fi
	((skipcols++))
done

touch everyother.csv

csvtool col $skipprnt train.csv > everyother.csv


# Every third column reversed

touch thirdcolumn.csv

numrows="$(csvtool height train.csv)"

icol=1
irow=1

while [ $irow -le $numrows ]
do
	outputrow=""
	icol=1
	while [ $icol -le $numcols ]
	do
		currval="$(csvtool sub $irow $icol 1 1 train.csv)"

		# if this isn't the first value, append a comma first
		if [ "$outputrow" != "" ]
		then
			outputrow="$outputrow,"
		fi

		if (($icol % 3 == 0))
		then
			# reverse the text in this column
			itext=${#currval}
			outval=""
			while [ $itext -gt 0 ]
			do
				((itext--))
				outval="$outval${currval:$itext:1}"
			done
			outputrow="$outputrow$outval"

		else
			# don't reverse the text
			outputrow="$outputrow$currval"
		fi

		((icol++))
	done

	((irow++))
	outputbody="$outputbody$outputrow\n"
done
printf "$outputbody" >  thirdcolumn.csv
