## Source for this file is under https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Assumption: Folder "UCI HAR Dataset" is in the working directory
## Attention: Execution could be longer

## 1. Merges the training and the test sets to create one data set
temp_train <- read.table("UCI HAR Dataset/train/X_train.txt")
temp_test <- read.table("UCI HAR Dataset/test/X_test.txt")
data_X <- rbind(temp_train, temp_test)

temp_train <- read.table("UCI HAR Dataset/train/y_train.txt")
temp_test <- read.table("UCI HAR Dataset/test/y_test.txt")
data_Y <- rbind(temp_train, temp_test)

temp_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
temp_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
data_Subject <- rbind(temp_train, temp_test)

rm(temp_train)
rm(temp_test)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement
data_Features <- read.table("UCI HAR Dataset/features.txt")
relevant_Features <- grep("-mean\\(\\)|-std\\(\\)", data_Features[, 2])
data_X <- data_X[, relevant_Features]

## 3. Uses descriptive activity names to name the activities in the data set
data_Activity <- read.table("UCI HAR Dataset/activity_labels.txt")
data_Y[, 1] = data_Activity[data_Y[, 1], 2]

## 4. Appropriately labels the data set with descriptive variable names
names(data_X) <- data_Features[relevant_Features, 2]
names(data_Y) <- "Activity"
names(data_Subject) <- "Subject"

data_All <- cbind(data_Subject, data_Y, data_X)

write.table(data_All, "mergedExtractData.txt", row.name=FALSE)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
unique_Subject <- unique(data_Subject)[, 1]
count_Subject <- length(unique_Subject)
count_Activity <- length(data_Activity[, 1])
count_Column <- dim(data_All)[2]

data_All_Average <- data_All[1:(count_Subject * count_Activity), ]

index_row = 1
for (index_Subject in 1:count_Subject) {
  for (index_Activity in 1:count_Activity) {
    data_All_Average[index_row, 1] = unique_Subject[index_Subject]
    data_All_Average[index_row, 2] = data_Activity[index_Activity, 2]
    temp_Source <- data_All[data_All$Subject==index_Subject & data_All$Activity==data_Activity[index_Activity, 2], ]
    data_All_Average[index_row, 3:count_Column] <- colMeans(temp_Source[, 3:count_Column])
    index_row = index_row + 1
  }
}

write.table(data_All_Average, "mergedExtractAverageData.txt", row.name=FALSE)
