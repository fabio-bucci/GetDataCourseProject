prepareDataset <- function(type,columnNames,activityLabels){
    if(type != 'train' && type != 'test') {
        stop("Expected train or test dataset")
    }
    ## 1.1 Read the data
    data <- read.table(paste('./UCI HAR Dataset/',type,'/X_',type,'.txt', sep = ""), header = FALSE, col.names=columnNames$colName)
    ## 1.2 Read subjects
    subjects <- read.table(paste('./UCI HAR Dataset/',type,'/subject_',type,'.txt', sep = ""), header = FALSE, col.names = "subject")
    ## 1.3 Read activities
    activities <- read.table(paste('./UCI HAR Dataset/',type,'/y_',type,'.txt', sep = ""), header = FALSE,col.names = "activityNum")
    activities$activityNum <- as.factor(activities$activityNum)
    levels(activities$activityNum) <- activityLabels$activityName
    ## 1.4 merge data, subjects and activities
    data <- cbind(data, subjects, activities)
    data
}




### 0. If data are not present, download and unzip the source file
if(!file.exists("./UCI HAR Dataset")){
    print("Downloading files...")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    destinationZipFile <- "./getdata-projectfiles-UCI HAR Dataset.zip"
    download.file(fileUrl,destfile=destinationZipFile,method="curl")
    unzip(destinationZipFile)
    file.remove(destinationZipFile)
}
## 0.1 Read activity labels
activityLabels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE, col.names=c("activityNum","activityName"))
## 0.2 Read the "features.txt" file and store column names
columnNames <- read.table('./UCI HAR Dataset/features.txt', header = FALSE, col.names=c("colNum","colName"))

### 1. Merges the training and the test sets to create one data set.

## Read the test data
testData <- prepareDataset('test',columnNames,activityLabels)
## Read the training data
trainData <- prepareDataset('train',columnNames,activityLabels)
## Merge the data frame
allData <- rbind(trainData,testData)

### 2. Extracts only the measurements on the mean and standard deviation for 
### each measurement. 

### 3. Uses descriptive activity names to name the activities in the data set

### 4. Appropriately labels the data set with descriptive variable names. 

### From the data set in step 4, creates a second, independent tidy data set with 
### the average of each variable for each activity and each subject.
