GettingAndCleaningData
======================

The Coursera "Getting and Cleaning Data" course project

This repo contains:
* Scripts:
* ** run_analysis.R  - main script, contains the function run_analysis()
* ** getDataProjectDownload.R  - called by the main script to perform download
* tidyDataSet.csv - the output file created by run_analysis(), represents a tidy data set
* CodeBook.pdf - a code-book for tidyDataSet.csv
* 

The process running by run_analysis() is fully automated, and does not require any additional manual intervention.
The process, step by step:
* if the directory "UCI HAR Dataset" does not exist, then:
* ** download the raw dataset from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* ** unzip the downloaded file
* read the features from features.txt
* match only the features containing the substring mean() or std()
* use the matched features as to create a column class of "numeric" or "NULL"
* Create subject data frame:
* ** read the subject to train set
* ** read the test set, and increase them by the maximum value of train set subject, in order to have a unique subject
* ** row merge the two subjects
* ** Name the column "Subject"
* Create activity data frame by:
* ** reading y_train.txt and y_test.txt
* ** row merge them
* ** replace the numbers by the activity labels from file activity_labels.txt
* ** Name the column "Activity"
* Create the X data frame of measurements by:
* ** reading only the matched column names, according to the above column classes
* ** row merging the data frames read from X_train.txt and X_test.txt
* ** Name the columns by the matched features
* Finally, create the tidy data set by:
* ** column merge of: subject, activity, X
* ** write the tidy data set to tidyDataSet.csv
* return the file name: "tidyDataSet.csv"
* 
