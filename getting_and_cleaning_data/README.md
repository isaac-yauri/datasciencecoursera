# Introduction

Course: Getting and Cleaning Data

Certification: Data Science - Johns Hopkins University

Project: Human Activity Recognition Using Smartphones Data Set

Source: www.smartlab.ws

Data Set: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 
we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for 
generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in 
fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, 
which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body 
acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a 
filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating 
variables from the time and frequency domain. See 'features_info.txt' for more details. 

# Files

CodeBook.md       : Describes the variables, the data, and procedures to clean up the data.

run_analysis.R    : Script in R to complete this steps.

                    1. Merges the training and the test sets to create one data set.
                    
                    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
                    
                    3. Uses descriptive activity names to name the activities in the data set
                    
                    4. Appropriately labels the data set with descriptive variable names described in CodeBook.
                    
                    5. From the data set in step 4, creates a second, independent tidy data set (tidy.txt) with the average
                       of each variable for each activity and each subject.

tidy.txt          : Tidy data after execute clean procedure with script run_analysis.R

# Executed Procedure by script

- Original files downloaded from Web Page to ./data directory.
- Unzip files
- Merge activity files from training and test datasets (X_train and X_test)
- Set varible names with features.txt
- Filter variables with mean and standard deviation only
- Merge subject files from training and test (subject_train.txt and subject_test.txt)
- Set variable name to "subject"
- Merge activity labels from training and test (y_train.txt and y_test.txt)
- Set variable name to "labels"
- Change current values on "labels" from 1:6 to labels on activity_labels.txt (descriptive variables)
- Merge Activity, Subject and Activity Labels
- Calculate the mean, and summarize by subject and activity_labels
- Write results on /data/tidy.txt
