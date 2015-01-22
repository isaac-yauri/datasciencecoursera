# script name: run_analysis.R
# Get and clean a Data Frame from UCI Machine Learning Repository
# Source: Human Activity Recognition Using Smartphones
# Script was created to work on Windows OS

# Load Libraries
library(dplyr)
library(plyr)

# Directory Verify
if(!file.exists("./data"))  {dir.create("./data")}

# Download Zip File
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/Dataset.zip", mode = "wb")
unzip("./data/Dataset.zip", exdir = "./data")

# files to load are:
#
# 'features.txt'            : The complete list of variables of each feature vector
# 'activity_labels.txt'     : Links the class labels with their activity name.
# 'train/X_train.txt'       : Training Activity set.
# 'train/y_train.txt'       : Training Activity Label.
# 'test/X_test.txt'         : Test Activity set.
# 'test/y_test.txt'         : Test Activity Label.
# 'train/subject_train.txt' : Each row identifies the subject who performed the activity for each window sample.
# 'test/subject_test.txt'   : Each row identifies the subject who performed the activity for each window sample.
#
# Loading, Merging Activity Sets and set Varible names with features.txt
train_activity <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
test_activity  <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
activity <- rbind(train_activity, test_activity)
features <- read.csv("./data/UCI HAR Dataset/features.txt", sep="", header=FALSE, stringsAsFactors=FALSE)
names(activity)<- features$V2

# Extracts only the measurements on the mean and standard deviation for each measurement
mean <- grep("mean", names(activity))
std <- grep("std", names(activity))
dataset <- cbind(activity[, mean], activity[, std])

# Loading and Merging Subjects (people) 
train_subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
test_subject  <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
subject <- rbind(train_subject, test_subject)
names(subject)<- "subject"

# Loading, Merging Activity Label and set variable name to "labels"
train_labels <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
test_labels  <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
activity_labels <- rbind(train_labels, test_labels)
names(activity_labels) <- "labels"

# Set Variable Name and values with activity_labels.txt
label <- read.csv("./data/UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE, stringsAsFactors=FALSE)
activity_labels <- label[activity_labels$labels, 2]

# Merge Data Sets
dataset <- cbind(activity_labels, dataset)
dataset <- cbind(subject, dataset)

# Group by: subject, activity_labels, and calculate mean of each variable.
tidy <- ddply(dataset, .(subject, activity_labels), function(x) colMeans(x[,3:81], na.rm = TRUE))

# Creating ./data/tidy.txt data
write.table(tidy, file = "./data/tidy.txt",row.name=FALSE)
