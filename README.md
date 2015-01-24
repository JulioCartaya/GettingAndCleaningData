 
## run_analysis.R
This script has been written by Julio A. Cartaya, to fulfill the Course Project requirement
for Coursera's "Getting and Cleaning Data" (Johns Hopkins University,
imparted by instructors Jeff Leeks, Roger D. Peng, Brian Caffo)  

This script should be run from the **_parent_** of the directory obtained by 
extracting the data archive documented at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

One of the most important assumptions of this script is that the structure and naming of the data is maintained: it will operate regardless of
changes in  

* the number of activities  
* the number of subjects  
* the number of observations per (activity, subject) combination  
* the number and types of variables measured in each observation  

... but it is critical that  

* the main data directory is called "UCI HAR Dataset", with sub-directories "train" and "test"  
* the main data directory describes activities in "activity_labels.txt" and lists variables in "features.txt"  
* that variable names that correspond to statistical _means_ match the regular expression "-mean[(]" (implicit in the codebook for the source dataset)  
* that variable names that correspond to _standard deviations_ match the regular expression "-std[(]" (implicit in the codebook for the source dataset)
* subdirectory "train" contains observations in "X_train.txt", as well as activities in "y_train.txt" and subjects in "subject_train.txt"  
* that each one of those files in "train" contains the same number of observations, arranged in exactly the same order 
* subdirectory "test" contains observations in "X_test.txt", as well as activities in "y_test.txt" and subjects in "subject_test.txt"  
* that each one of those files in "test" contains the same number of observations, arranged in exactly the same order

### Script Operation
The script starts by reading "activity_labels.txt"", and defining an auxiliary function to translate activities encoded as numbers, decoding them into descriptive activity names, it also reads from "features.txt", the names of the variables measured in the "train" and "test" datasets. 

The second phase of the script obtains a unified data set from the "train" and "test" datasets. In order to do that  
1. reads "y_train.txt" (activities), "subject_train.txt" (subjects), and "X_train.txt" (observations) from subdirectory "train" into temporary tables, and column-binds them to generate "train_tbl"  
2. reads "y_test.txt" (activities), "subject_test.txt" (subjects), and "X_test.txt" (observations) from subdirectory "test" into temporary tables, and column-binds them to generate "test_tbl"  
3. Row-binds "train_tbl" and "test_tbl" to produce "tmp_tbl" (another temporary table) containing all observations, then inserts variable names, gets rid of duplicate columns, and decodes activity names, calling the result "uni_tbl" (unified table) that corresponds to step 4 of the project description by the instructors  

The third (and final) phase of the script is obtaining a tidy dataset from "uni_tbl", containing averages for each (activity, subject combination).  Clearly, to do that the script  
1. groups the observations in "uni_tbl" by (activity, subject), and runs **aggregate** (from tidyr) to calculate the averages  
2. drops columns "act" and "sub" which would now be redundant (thus making the table _untidy_), and renames columns to something that signals these are now averages  
3. writes the data to file "tdy_tbl.txt" as requested by the instructors in step 5 of the project description  

#### Notes
The script makes an effort to  
+ avoid unnecessary warnings (mostly)  
+ clean up after itself, eliminating from memory everything except parameters and tables of interest  
+ leave the environment as it was, by saving/restoring the initial working directory  