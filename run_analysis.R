# Assignment instructions:
# Step 1. Merges the training and the test sets to create one data set.
# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Step 3. Uses descriptive activity names to name the activities in the data set
# Step 4. Appropriately labels the data set with descriptive variable names. 
# Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# entry point: run_analysis()
# this will return a data table object, and create tidydata.txt

# use pipe
library(magrittr)
library(dplyr)
library(data.table)

# data is in a folder called "UCI HAR Dataset"
dataDir = "UCI HAR Dataset"

# common variables used by a few functions
indices = 0


# load a dataset
# type is either 'train' or 'test'
# dataset consists of 3 files:
# 561-feature vectors (X_***.txt)
# activity labels (y_***.txt)
# subject id (subject_***.txt)
loadDataset = function(type){
  print(paste('loading', type, 'dataset...'))

  featureFilename = paste('X_', type, '.txt', sep='')
  activityFilename = paste('y_', type, '.txt', sep='')
  subjectFilename = paste('subject_', type, '.txt', sep='')

  featureData = read.table(paste(dataDir, type, featureFilename, sep='/'))
  activityData = read.table(paste(dataDir, type, activityFilename, sep='/'))
  subjectData = read.table(paste(dataDir, type, subjectFilename, sep='/'))
  
  # append 2 extra columns
  featureData[,'subject'] = subjectData[,1]
  featureData[,'activity'] = activityData[,1]
  return (featureData)
}

# Step 1. Merges the training and the test sets to create one data set.
mergeDatasets = function(){
  testDataset = loadDataset('test')
  trainDataset = loadDataset('train')

  print('merging datasets...')
  dataset = rbind(testDataset, trainDataset)
  return (dataset)
}

# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
extractMeanStd = function(dataset){
  print('extract mean std...')

  # need to parse the features.txt to get column indices
  features = read.table(paste(dataDir, 'features.txt', sep='/'))
  meanIndices = filter(features, grepl('mean()', V2))
  stdIndices = filter(features, grepl('std()', V2))
  
  indices <<- rbind(meanIndices, stdIndices)
  indices <<- arrange(indices, V1)

  # remember to add indices for last 2 columns (subject, activities)
  # convert col 2 to char so rbind will not complain
  indices[,2] <<- sapply(indices[,2],as.character)
  indices <<- rbind(indices, c(562, 'subject'))
  indices <<- rbind(indices, c(563, 'activity'))
  # col 1 was somehow converted to char, so convert it back
  indices[,1] <<- sapply(indices[,1],as.integer)
  
  result = select(dataset, indices$V1)
  return (result)
}

# Step 3. Uses descriptive activity names to name the activities in the data set
transformActivityLabels = function(dataset){
  print('activity names...')

  activityNames = read.table(paste(dataDir, 'activity_labels.txt', sep='/'))
  dataset = mutate(dataset, activity_name = activityNames[activity,2])
  
  # include the new names so that Step 4 will be correct
  indices <<- rbind(indices, c(564, 'activity_name'))
  return (dataset)
}

# Step 4. Appropriately labels the data set with descriptive variable names. 
transformVariableNames = function(dataset){
  print('meaningful variable names...')
  
  # the names are filtered from features.txt
  names(dataset) = indices$V2
  return (dataset)
}

# Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
summariseData = function(dataset){
  # delete the activity code column
  dataset$activity = NULL

  dt = data.table(dataset)
  dt2 = dt[, lapply(.SD, mean), by = list(subject, activity_name)]
  dt2 = arrange(dt2, subject, activity_name)
  return (dt2)
}

# for submission
writeToFile = function(dataset){
  write.table(dataset, file='tidydata.txt', row.name=FALSE)
  return (dataset)
}

# entry point
run_analysis = function(){
  # Step 1. Merges the training and the test sets to create one data set.
  mergeDatasets() %>%
    # Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    extractMeanStd() %>%
    # Step 3. Uses descriptive activity names to name the activities in the data set
    transformActivityLabels() %>%
    # Step 4. Appropriately labels the data set with descriptive variable names. 
    transformVariableNames() %>%
    # Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    summariseData() %>%
    # for submission
    writeToFile() %>%
  return()
}

