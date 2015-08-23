# Set the working directory to where the data was unzipped - this should be modified
# as per system set up
setwd("C:/Users/Vicky/datasciencecoursera/GettingAndCleaningDataProj/UCI HAR Dataset")

## Step 1
## Merge the training and the test sets to create one data set.
##############################################################
# Read in the training data
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")
# Read in the test data
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")
# Read in the activities and the features
features <- read.table("features.txt")


# Combine the training datasets together
#trainingDf <- cbind(subject_train, y_train,x_train)

# Combine the test datasets together
#testDf <- cbind(subject_test,y_test, x_test)

# Merge the training and test tables
trainingAndTestDf <- rbind(x_train, x_test)
activityDf <- rbind(y_train, y_test)
subjectDf <- rbind(subject_train, subject_test)
colnames(trainingAndTestDf) <- features[,2]

## Step 2
## Extract only the measurements on the mean and standard deviation for each measurement.
###########################################################################################
# Find the mean and sd columns
meanAndSdColumns <- grep("-(mean|std)\\(\\)", features[,2])
# Subset the dataset based on these columns
trainingAndTestDf <- trainingAndTestDf[,meanAndSdColumns]

## Step 3
## Uses descriptive activity names to name the activities in the data set
###########################################################################################
# Read in the activity labels
activity_labels <- read.table("activity_labels.txt")
# Merge the activity training and test tables
activityDf <- rbind(y_train, y_test)
# Apply the activity labels to the activity
activityDf[,1] <- activity_labels[activityDf[,1],2]

## Step 4
## Appropriately labels the data set with descriptive variable names.
###########################################################################################
# Set the labels for the data set with the descriptive variable names
colnames(subjectDf) <- "subject"
colnames(activityDf) <- "activity"
# Merge the subject, activity and training/test data tables
trainingAndTestDf <-
    cbind(subjectDf, activityDf, trainingAndTestDf)


## Step 5
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###########################################################################################
# create the tidy data set grouped by subject and activity and use the summarise_each function to get the mean of each variable
tidyDataset <-
    trainingAndTestDf %>% group_by(subject, activity) %>% summarise_each(funs(mean))
# Write the new tidy data set to a new file.
write.table(tidyDataset, './tidyData.txt',row.names = FALSE);
