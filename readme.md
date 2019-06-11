# Devops Challenge 4

This script requires that `csvtool` be installed on the system.

This tool can easily be installed on any Ubuntu based system with:

`sudo apt install csvtool`

There are three parts to this shell script:

## Reversed Columns
The logic here is similar to the Python challenge. We find out how many columns there are, and then create a list of numbers counting down to 1.

We can then pass this list of numbers to the csvtool, which will interpret this as the arrangement of columns for the output:

`csvtool col $bckwrdsprnt train.csv > backwards.csv`

This call to csvtool will output columns in the order indicated by `$bckwardsprnt` from the file `train.csv` to the output file `backwards.csv`.

## Every Other Column
Similar to the reversed columns logic, we are creating a list of the numbers which correspond to the columns we want to get.

This number is passed to the `csvtool` which will create the output and save it in `everyother.csv`.

## Every Third Column Reversed
This solution required a bit more effort to get working, and although it runs, it requires an individual call to `csvtool` for each cell in the csv file, which gives it a significant amount of overhead.

This solution was chosen as a way to keep the script flexible and allow it to take in a dynamic number of columns and ensure that every third one is output correctly. If assumptions are made about the number of columns, we could greatly reduce the number of calls to `csvtool` and therefore speed up the process. This would be done by pulling in an entire row at a time, and storing each value in its own variable, and reversing every third variable.