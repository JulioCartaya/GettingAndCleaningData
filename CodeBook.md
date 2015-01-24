---
output: html_document
---
## Data In tdy_tbl

### Introduction
The tdy_tbl dataset has been obtained processing data from "Human Activity Recognition Using Smartphones Dataset" described at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

This processing was performed using R3.1.2, using a script written by Julio A. Cartaya (jc061m@att.com) as part of the Course Project for "Getting and Cleaning Data" (Johns Hopkins University, imparted by instructors Jeff Leeks, Roger D. Peng, Brian Caffo)  

### Study Design
The design and data collected as part of the "Human Activity Recognition Using Smartphones Dataset" sources, are available as an archive at
http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip

Their original experiment was carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset was then partitioned into two sets, where 70% of the volunteers was randomly selected for generating the training data and 30% for generating the test data.

As part of the original experiment calculations,  

+ the sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window)  
+ the sensor acceleration signal, which has gravitational and body motion components, was separated using a low-pass Butterworth filter into body acceleration and gravity    
+ using time windows, a vector of features was obtained by calculating variables from the time domain   
+ further processing (fft) provided variables in the frequency domain  

Details are in the 'features_info.txt' file at the base of the archive mentioned above.

In this experiment (data in tdy_tbl), we downloaded the original data, and  
1. Merged the training and the test sets to create one data set  
2. Extracted only the measurements on the mean and standard deviation for each measurement of the original set, discarding all other variables  
3. Inserted descriptive activity names to name the activities in the original data set    
4. Labeled appropriately the variable names in the original set  
5. Created tdy_tbl, an independent tidy data set with the average of each variable from the original data set, grouped by activity and subject   

### Code Book
The features in the original database come from raw readings of the accelerometer (in standard gravity units 'g') and gyroscope 3-axial raw signals (units: radians/second) tAcc-XYZ and tGyro-XYZ. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).

These time domain signals (note the use of the prefix 't', to denote time domain) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the use of the prefix 'f', to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern listed below, in which:  
+ '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions
+ mean(): Mean value 
+ std(): Standard deviation

So the final list of variable name patterns in the measurements of the original study includes   

Name Pattern					 	| Number of variables that use this pattern  
----------------------- | -------------------  
tBodyAcc-mean()-XYZ  		| 3  
tBodyAcc-std()-XYZ  		|	3  
tGravityAcc-mean()-XYZ  |	3  
tGravityAcc-std()-XYZ  	|	3  
tBodyAccJerk-mean()-XYZ |	3  
tBodyAccJerk-std()-XYZ  |	3  
tBodyGyro-mean()-XYZ  	|	3  
tBodyGyro-std()-XYZ  		|	3  
tBodyGyroJerk-mean()-XYZ| 3  
tBodyGyroJerk-std()-XYZ |	3  
tBodyAccMag-mean()			| 1  
tBodyAccMag-std()				| 1  
tGravityAccMag-mean()		| 1  
tGravityAccMag-std()			| 1  
tBodyAccJerkMag-mean()		| 1  
tBodyAccJerkMag-std()		| 1  
tBodyGyroMag-mean()			| 1  
tBodyGyroMag-std()				| 1  
tBodyGyroJerkMag-mean()	| 1  
tBodyGyroJerkMag-std()		| 1  
fBodyAcc-mean()-XYZ  		|	3  
fBodyAcc-std()-XYZ  		|	3  
fBodyAccJerk-mean()-XYZ | 3  
fBodyAccJerk-std()-XYZ  | 3  
fBodyGyro-mean()-XYZ  	| 3  
fBodyGyro-std()-XYZ  		| 3  
fBodyAccMag-mean()				| 1  
fBodyAccMag-std()				| 1  
fBodyAccJerkMag-mean()		| 1  
fBodyAccJerkMag-std()		| 1  
fBodyGyroMag-mean()			| 1  
fBodyGyroMag-std()				| 1  
fBodyGyroJerkMag-mean()	| 1  
fBodyGyroJerkMag-std()		| 1  


for a total of 66 variables for each (activity, subject) pair. Note this study splits each observation into 3 files (one describing the activities, one describing the subjects, and one describing the measurements for each observation).

In our study we have 2 variables to describe the (activity, subject) groups, and 66 that correspond to the average (arithmetic mean) of each of the variables selected from the original study within each group. Using the same pattern notation, our variables are named  

Name Pattern								 	| Number of variables that use this pattern  
----------------------------- | -------------------  
ACT (activity)								| 1  
SUB (subject)									| 1  
AVG:tBodyAcc-mean()-XYZ  		| 3  
AVG:tBodyAcc-std()-XYZ  			|	3  
AVG:tGravityAcc-mean()-XYZ  	|	3  
AVG:tGravityAcc-std()-XYZ  	|	3  
AVG:tBodyAccJerk-mean()-XYZ 	|	3  
AVG:tBodyAccJerk-std()-XYZ  	|	3  
AVG:tBodyGyro-mean()-XYZ  		|	3  
AVG:tBodyGyro-std()-XYZ  		|	3  
AVG:tBodyGyroJerk-mean()-XYZ	| 3  
AVG:tBodyGyroJerk-std()-XYZ 	|	3  
AVG:tBodyAccMag-mean()				| 1  
AVG:tBodyAccMag-std()				| 1  
AVG:tGravityAccMag-mean()			| 1  
AVG:tGravityAccMag-std()			| 1  
AVG:tBodyAccJerkMag-mean()		| 1  
AVG:tBodyAccJerkMag-std()			| 1  
AVG:tBodyGyroMag-mean()				| 1  
AVG:tBodyGyroMag-std()				| 1  
AVG:tBodyGyroJerkMag-mean()		| 1  
AVG:tBodyGyroJerkMag-std()		| 1  
AVG:fBodyAcc-mean()-XYZ  		|	3  
AVG:fBodyAcc-std()-XYZ  			|	3  
AVG:fBodyAccJerk-mean()-XYZ 	| 3  
AVG:fBodyAccJerk-std()-XYZ  	| 3  
AVG:fBodyGyro-mean()-XYZ  		| 3  
AVG:fBodyGyro-std()-XYZ  		| 3  
AVG:fBodyAccMag-mean()				| 1  
AVG:fBodyAccMag-std()					| 1  
AVG:fBodyAccJerkMag-mean()		| 1  
AVG:fBodyAccJerkMag-std()			| 1  
AVG:fBodyGyroMag-mean()				| 1  
AVG:fBodyGyroMag-std()				| 1  
AVG:fBodyGyroJerkMag-mean()		| 1  
AVG:fBodyGyroJerkMag-std()		| 1  
