# GetDataCourseProject
## Course Project repo for "Getting and Cleaning Data" Coursera

This repo contains the project assignment for the "Getting and Cleaning Data" course.
You can find the detailed description of the assignment here:
https://class.coursera.org/getdata-011/human_grading
It contains three files:
* Readme.md
* run_analysis.R
* CodeBook.md
A detailed description of the purpose and usage of each file follows.

### Readme.md
This file. Describes the repo content.

### run_analysis.R
This code file prepare the tidy dataset starting form the source data.
The code looks expects you already have the source data directory downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and expanded in your working directory.
Otherwise (if a directory called *"UCI HAR Dataset"* is not present in your working directory), the script will download the file for you and unzip it
in your working directory (this can take time, depending from you internet connection speed).
The script reads the activity label and features files to give proper names to activities and variables.
Because the test and train data have identical structure, a function *prepareDataset* is provided to read both of them. 
The function:
1. Reads the data file
2. Assigns the proper column names
3. Reads the subjects file
4. Reads the activities file, transforming values in factors with the descriptive label
5. Merges data, subjects and activities in a single data frame

The script reads test and train data using the *prepareDataset* function and merge them to obtain a single dataframe with all the values.
From this dataframe all columns representing mean and standard deviation are selected (also activity and subject columns are kept of course). 
This is done using a regular expression that leverage the column names pattern.

Then, from this data set a second, independent tidy data set is created with the average of each variable for each activity and each subject.
To complete this step the _dplyr_ package has been used, so you need to have this package installed to complete the script.


## CodeBook.md
This file describes the variables and the data.