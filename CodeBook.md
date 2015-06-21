Getting and Cleaning Data Course Project Code Book
==================================================
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.
* Source of the data https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* Full description of the data http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

* Script run_analysis.R performs the following steps to clean the data:
1. Read X_train.txt and X_test.txt and concatenate it to *data_X* (10299x561 data frame)
2. Read y_train.txt and y_test.txt and concatenate it to *data_Y* (10299x1 data frame)
3. Read subject_train.txt and subject_test.txt and concatenate it to *data_Subject* (10299x1 data frame)
4. Read features.txt to *data_Features* (561x2 data frame)
5. Extract only "-mean()" and "-std()" to *relevant_Features* (List of 66 int values)
6. Reduce *data_X* with the *relevant_Features* to *data_X* (10299x66 data frame)
7. Read activity_labels.txt to *data_Activity* (6x2 data frame)
8. Replace it in *data_Y*
9. Proper names for *data_X* (*data_Features*), *data_Y* (Activity) and *data_Subject* (Subject) columns
10. Combine *data_Subject*, *data_X* and *data_Y* to *data_All* (10299x68 data frame)
  - The "Subject" column contains integers that range from 1 to 30 inclusive
  - The "Activity" column contains 6 kinds of activity names (walking, walkingupstairs, walkingdownstairs, sitting, standing, laying)
  - The last 66 columns contain measurements that range from -1 to 1 exclusive
11. Write *data_All* to "mergedExtractData.txt" in the current working directory
12. Create new tidy data set with the average of each measurement for each activity and each subject to *data_All_Average* (180x68 data frame)
  - 30 unique subjects
  - 6 uniques activities
13. Write *data_All_Average* to "mergedExtractAverageData.txt" in the current working directory