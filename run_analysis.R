# Using the accelerometer data from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# create a tidy data set that can be used for data analysis
# The obtained dataset is randomly partitioned 70% of participants into 
# training and 30% test data

# Each row is a single (561-feature vector) record corresponding to an activity

#1 Merges the training (7352x561) and the test (2947x561) sets to 
# create one data set

# Read in all of the data
read_uci_data <- function() {
# features.txt contains the names of each of the records in the feature vector
  features <- read.table("./UCI HAR Dataset/features.txt",colClasses = "character")

# Observed data sets
# Use the features dataframe to label out observed data columns when reading in
  testAct <- read.table("./UCI HAR Dataset/test/y_test.txt", colClasses = "numeric", 
                          col.names = "activity")
  testSet <- read.table("./UCI HAR Dataset/test/X_test.txt", colClasses = "numeric",
                        col.names = features[,2])
  testSubj <- read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses = "integer",
                         col.names = "subject")

  trainAct <- read.table("./UCI HAR Dataset/train/y_train.txt", colClasses = "numeric", 
                           col.names = "activity")
  trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt", colClasses = "numeric",
                         col.names = features[,2])
  trainSubj <- read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses = "integer",
                       col.names = "subject")

# combine all of the data into one dataframe
  testData <- data.frame(testSubj, testAct, testSet)
  trainData <- data.frame(trainSubj, trainAct, trainSet)
  data <- rbind(testData, trainData)
  return(data)
}

#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
getMeasuresColumns <- function(data) {
  # Create an array of column identifiers that contain mean measurements
  # Find the "mean" & "std" columns with grepl, get the column numbers with which
  meanColumns <- which(grepl("mean", names(data), ignore.case = TRUE))
  stdColumns <- which(grepl("std", names(data), ignore.case = TRUE))
  
  #supply the slice with the columns for the mean and std values (and keep the activity & subject)
  measureColumns <- sort(c(1,2, meanColumns, stdColumns))
  return(data[,measureColumns])
}

#3 Uses descriptive activity names to name the activities in the data set
applyActivityNames <- function(data) {
  # activity_labels.txt contains the descriptions of the activity peformed 
  # during the observation period
  activity <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses = "character",
                         col.names = c("id","activity"))
  data$activityName <- activity[data$activity,2]
  return(data)
}

#4 Appropriately labels the data set with descriptive variable names.
# Using the features dataframe (see step 1) to label the observation columns appropriately

#5 From the data set in step 4, creates a second, independent 
#  tidy data set with the average of each variable for each activity and each subject.

aveData <- function(data){
  # Aggregate the data over the data columns, take the mean, grouping by activityName
  # and subject
  tidy <- aggregate(d3[,3:88],list(activityName = d3$activityName, subject = d3$subject),mean)
  return(tidy)
}

# Run through steps 1-5 to generate and return the tidy dataset
getTidyData <- function(){
  
# 1. Read in the data (also 4. apply feature labels to the columns)
  print("Reading in data")  
  data <- read_uci_data()
  
# 2. Pull out the mean and std columns
  print("Extracting the mean and std columns")
  data <- getMeasuresColumns(data)

# 3. Add in the activity names
  print("Applying activity names to mean and std data")
  data <- applyActivityNames(data)

# 4. Feature labels applied in step 1
# 5. Take the average of each value by activity and subject
  print("Calculating the mean feature values")
  data <- aveData(data)
# write the data to a text file in your current working directory
  write.table(data,"tidy_data.txt",row.names = FALSE)
  return(data)
}