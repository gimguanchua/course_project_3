# course_project_3
Getting and Cleaning Data

## Data Source

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


## The Variables

A detailed explanation of the data and its directory structure is available in the file called README.txt in the dataset.

The output from the analysis consists of the following variables:

+ subject
This is the id of the subject

+ activity_name
This is the activity performed during the experiment. The list of activities is defined in activity_labels.txt in the dataset.

+ Various means and standard variations of the measurements
For the experiment, each subject has performed numerous activities. And each activity was measured over a few time windows.
The purpose of this analysis is find the average of these time window measurements for each subject and their respective activities.
The dataset consists of 561 feature set of measurements. This analysis only focus on means and standard variations features.
Thus the variables are the average of the respective measurements for each subject and activity. For example, the column "tBodyAcc-mean()-X" is the average values of the measurement "tBodyAcc-mean()-X" (you can refer to the code book for the dataset for a detailed explanation of that) over the measurement time windows for the whole experiment.

## The Procedure

1. Merges the training and the test sets to create one data set.
The dataset is split into 2 sets - "training" and "test". As the analysis is performed on all the data, we need to merge them first.
The subject and activity data are also in separate files, which we also need to merge in.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
Using the file features.txt, we parse through the feature list looking for features that contain the terms "mean()" or "std()". Extracting only these features, the first column of the data frame forms the index list to extract the relevant columns from the merged data created in (1). Since we have merged in subject and activity data, and they do not appear in the features list data, we have to add these into the index list as well.

3. Uses descriptive activity names to name the activities in the data set
As the activity data is in code, we need to create a new column for "activity_name" using the mapping data of activity_labels.txt. We can remove the "activity" column since it is not used.

4. Appropriately labels the data set with descriptive variable names.
As the data files do not have header names, the resultant data frame has arbitrary names given to each columns. Using the second column of the index list created in (2), we replaced the column names with more meaningful ones that can be referenced for more detail in the dataset code book.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
We created a new table listed by subject and activity_name, and collapsed the repetitions into means.
