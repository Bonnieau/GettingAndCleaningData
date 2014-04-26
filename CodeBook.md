# CodeBook for Project
## Infomation for Original Source Data:
### Data location:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
###  Data description:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## Project Source Data Description
  The project imports training and testing data from original source.
  Both training and testing data contain 561 measurements data produced by 30 subjects via performed 6 activities.
### Measurement Data
  1. These data are collected from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. The data description can be found in features_info.txt
  2. The descriptive names for each measurement can be found in features.txt. There are 561 different measurements.
  3. The measurement data are contained in files X_train.txt (7352 rows)and X_test.txt (2947 rows).
  4. There are 561 columns in measurement dataset.
 
  
### Activities data
  1. The activity data are contained in files Y_train.txt (7352 rows) and Y_test.txt (2947 rows).
  2. The descriptive name for each activity can be found in activity_labels.txt.There are 6 different kinds of activities.
  3. There is 1 column in activity dataset
  
### Subject data
  1. The subject data are contained in files subject_train.txt (7352 rows) and subject_test.txt (2947 rows).
  2. There is 1 column in subject dataset.
  
## Project Data Process Description
### Getting data
  1. Import X_train.txt and X_test.txt and merge into measurement dataset (10299 rows and 561 columns)
  2. Import Y_train.txt and Y_test.txt and merge into activity dataset (10299 rows and 1 columns)
  3. Import subject_train.txt and subject_test.txt and merge into subject dataset (10299 rows and 1 column)

### Extraction mean and std data from measurement data
  1. Import features.txt to get dataset (561 rows and 2 columns) contains descriptive measurement names.
  2. Get the index for feature names contain mean 
  3. Get the index for feature anmes contain std
  4. Merge 2 index datasets, get unique row ID and ordered for low to high
  5. Use index to extract mean and std data from measurement dataset
  6. Use index to extract descriptive feature name for mean and std measurement data.
  7. Label the mean and std measurement data with descriptive name
  8. There are totally 79 different kinds of mean and std measurement data. The extracted dataset contains 79 columns and 10299 rows.

### Give descriptive names to the activity data 
  1. Import activity_labels.txt to get dataset contains descriptive activity names.
  2. Give the name to the activity dataset.
  3. Label this data as activity (column name).

### Produce the dataset with descriptive labels
  1. Labelled the subject data as subject (column name)
  2. Merge the 3 proper labelled data to one dataset. (10299 rows and 81 columns)
  
### Produce the tidy dataset
  1. Create factor data baseed on subject and activity columns. There are 180 levels.
  2. Use aggregate function to computer mean for each measurement based on subject and activity factor.
  3. Remove extra columns (subject, activity) to use factor as row identifiers.
  4. Now the dataset contains 180 rows (180 levels) and 80 columns (79 measurement data and 1 identifier)
  5. Export the dataset to generate txt file contain the tidy dataset.
