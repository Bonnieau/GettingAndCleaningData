GettingAndCleaningData
======================

Repo for coursera "Getting and Cleaning Data" project

## Readme file for Project
### Procedure to generate tidy dataset

 1. Download data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 2. Unzip the data into local machine, you will get "UCI HAR Dataset" directory
 3. Set "UCI HAR Dataset" directory as working directory for R.
 4. Copy run_analysis.R into R working directory
 5. Source("run_analysis.R") in R
 6. It will produce tidy_dataset.txt in the working directory
 7. To use "tidy_dataset.txt", import it use read.table("tidy_dataset.txt"). It will produce data frame contains 180 rows and 80 columns.
 8. Check on tidy dataset in R, there are 180 rows and 80 columns.
