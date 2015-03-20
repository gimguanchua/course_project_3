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
This is the activity performed during the experiment

+ Various means and standard variations of the measurements
This analysis only focus on means and standard variations features of the dataset (out of a total of 561 features).
This is the average of the respective measurements for each subject and activity. For example, the column "tBodyAcc-mean()-X" is the average values of the measurement "tBodyAcc-mean()-X" (you can refer to the code book for the dataset for a detailed explanation of that) over the measurement time windows for the whole experiment.

