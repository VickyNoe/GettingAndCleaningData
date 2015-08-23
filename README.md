# GettingAndCleaningData

## Source Data  
A full description of the source data is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Tidying and Cleaning of the data
run_anlysis.R is an R script that reads in, merges and cleans up the training and test sets of data for the Human Activity Recognition Using Smartphones Dataset.

The basic steps from the script are as follows:

###Step 1:
The script reads in the test(x_test.txt) and training (x_training.txt) data sets and merges these datasets to create one data set. It also reads in and merges the test and training subject datasets (subject_test.txt and subject_training.txt) and reads in and merges the activity data sets (y_training.txt and y_test.txt). It reads in the descriptive variable names (from the features.txt) and the activity labels (activity_labels.txt).  These datasets will be used in the subsequent processing steps. 

###Step 2:
The script greps the features dataset to find only the mean and standard deviation related columns.  It then uses the result to subset the dataset to only include these measurements.

###Step 3:
The script reads in the activity labels (activity_label.txt) and the activity datasets (y_train.txt and y_test.txt). It merges the training and test datasets and then applies the descriptive activity names from the activity labels dataset to the activities in the data set

###Step 4:
It sets the labels for the data set with the descriptive variable names.  This was partially done in step 1, so this step just adds the last labels and then merges the activity, subject and main datasets together.

###Step 5:  
From the data set in step 4, a second, independent tidy data set is created with the average of each variable for each activity and each subject. The group_by and summarise_each functions are used for this. The tidy data set is then written out to a file.

