prepareDataset <- function(type,columnNames,activityLabels){
    if(type != 'train' && type != 'test') {
        stop("Expected train or test dataset")
    }
    ## Read the data and appropriately labels the data set with descriptive variable names.
    data <- read.table(paste('./UCI HAR Dataset/',type,'/X_',type,'.txt', sep = ""), header = FALSE, col.names=columnNames$colName)
    ## Read subjects file
    subjects <- read.table(paste('./UCI HAR Dataset/',type,'/subject_',type,'.txt', sep = ""), header = FALSE, col.names = "subject")
    ## Uses descriptive activity names to name the activities in the data set
    activities <- read.table(paste('./UCI HAR Dataset/',type,'/y_',type,'.txt', sep = ""), header = FALSE,col.names = "activityNum")
    activities$activityNum <- as.factor(activities$activityNum)
    levels(activities$activityNum) <- activityLabels$activityName
    ## Merge data, subjects and activities
    data <- cbind(data, subjects, activities)
    data
}




### If data folder is not present, download and unzip the source file
if(!file.exists("./UCI HAR Dataset")){
    print("Downloading files...")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    destinationZipFile <- "./getdata-projectfiles-UCI HAR Dataset.zip"
    download.file(fileUrl,destfile=destinationZipFile,method="curl")
    unzip(destinationZipFile)
    file.remove(destinationZipFile)
}
## Read activity labels
activityLabels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE, col.names=c("activityNum","activityName"))
## Read the "features.txt" file and store column names
columnNames <- read.table('./UCI HAR Dataset/features.txt', header = FALSE, col.names=c("colNum","colName"))

## Read the test data
testData <- prepareDataset('test',columnNames,activityLabels)
## Read the training data
trainData <- prepareDataset('train',columnNames,activityLabels)
## Merges the training and the test sets to create one data set.
allData <- rbind(trainData,testData)

### 2. Extracts only the measurements on the mean and standard deviation for 
### each measurement. 


### 4. Appropriately labels the data set with descriptive variable names. 

### From the data set in step 4, creates a second, independent tidy data set with 
### the average of each variable for each activity and each subject.

