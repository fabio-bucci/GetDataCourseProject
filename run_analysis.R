## This function prepares test and train data sets reading the data file, reading the subject file, reading the activity file and 
## properly naming all variables with descriptive names
prepareDataset <- function(type,columnNames,activityLabels){
    if(type != 'train' && type != 'test') {
        stop("Expected train or test dataset")
    }
    # Read the data
    data <- read.table(paste('./UCI HAR Dataset/',type,'/X_',type,'.txt', sep = ""), header = FALSE)
    # Label the data with variable names
    names(data) <- columnNames$colName
    # Read subjects file
    subjects <- read.table(paste('./UCI HAR Dataset/',type,'/subject_',type,'.txt', sep = ""), header = FALSE, col.names = "subject")
    # Uses descriptive activity names to name the activities in the data set
    activities <- read.table(paste('./UCI HAR Dataset/',type,'/y_',type,'.txt', sep = ""), header = FALSE,col.names = "activity")
    activities$activity <- as.factor(activities$activity)
    levels(activities$activity) <- activityLabels$activityName
    # Merge data, subjects and activities
    data <- cbind(data, subjects, activities)
    data
}

## If data folder is not present, download and unzip the source file
if(!file.exists("./UCI HAR Dataset")){
    print("Downloading files...")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    destinationZipFile <- "./getdata-projectfiles-UCI HAR Dataset.zip"
    download.file(fileUrl,destfile=destinationZipFile,method="curl")
    unzip(destinationZipFile)
    file.remove(destinationZipFile)
}
# Read activity labels
activityLabels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE, col.names=c("activity","activityName"))
# Read the "features.txt" file and store column names
columnNames <- read.table('./UCI HAR Dataset/features.txt', header = FALSE, col.names=c("colNum","colName"))

# Read the test data
testData <- prepareDataset('test',columnNames,activityLabels)
# Read the training data
trainData <- prepareDataset('train',columnNames,activityLabels)
# Merges the training and the test sets to create one data set.
allData <- rbind(trainData,testData)

### Extracts only the measurements on the mean and standard deviation for 
### each measurement. 

# Select all columns representing mean and standard deviation values based on 
# the dataset variables naming convention, plus the activity and subject columns
columnSelection <- c(grep("*-mean\\(\\)*|*-std\\(\\)*",names(allData), value = TRUE),"activity","subject")
allDataMeanStd <- allData[,names(allData) %in% columnSelection]

### From the data set in step 4, creates a second, independent tidy data set with 
### the average of each variable for each activity and each subject.
library(dplyr)
res <- allDataMeanStd %>% group_by(activity,subject) %>% summarise_each(funs(mean))

# Export tidy data set for the assignment
# write.table(res,"tidy_dataset.txt",row.name = FALSE)