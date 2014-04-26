#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
# script name: run_analysis.R                                                               #
# Source data URL:                                                                          #
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip    #
# function description:                                                                     #
# This script does the following: 														    #
# 1. Merges the training and the test sets to create one data set.							#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.#
# 3. Uses descriptive activity names to name the activities in the data set.				#
# 4. Appropriately labels the data set with descriptive names. 					#
# 5. Creates a second, independent tidy data set with the average of each variable for 		#
#    each activity and each subject. 														#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#

#-------------------------------------------------------------------
# Merges the training and the test sets to create one data set.
# import data: X_train.txt,X_test.txt,
#             Y_train.txt,Y_test.txt,
#             subject_train.txt,subject_test.txt
# produce data: merged measurement dataset, 
#               merged activities dataset,
#               merged subject dataset,
#               merged dataset contains measurement, activities and subjects

#read x_train data into r data frame xtrain
x.train<-read.table("train/X_train.txt")
#read x_test data into r data frame xtest
x.test<-read.table("test/X_test.txt")

#read y_train data into r data frame ytrain
y.train<-read.table("train/Y_train.txt")
#read y_test data into r data frame ytest
y.test<-read.table("test/Y_test.txt")

#read subject_train data into r data frame subjectTrain
subject.train<-read.table("train/subject_train.txt")
#read subject_test data into r data frame subjectTest
subject.test<-read.table("test/subject_test.txt")

#merge X_train and X_test dataset into x.set
x.set<-rbind(x.train,x.test)

#merge Y_train and Y_test dataset into y.set
y.set<-rbind(y.train,y.test)

#merge subject_train and subject_test dataset into sub.set
sub.set<-rbind(subject.train,subject.test)

#merge all the data into oneset
oneset<-cbind(x.set,y.set,sub.set)

#-----------------------------------------------------------------------
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Label the measurement data with descriptive name
# import data: features.txt
# produce data: measurement dataset contain mean and standard deviation;
#               also labelled with descriptive name.

#import feature name
feature<-read.table("features.txt")

#get feature contain mean
mean<-feature[grep("mean",feature$V2),]

#get features contain std
std<-feature[grep("std",feature$V2),]

#merge mean and std
mean.std(mean,std)

#get index for mean and std
ind<-sort(unique(mean.std[,1]))

#extract the mean and std measurement
x.meanstd<-x.set[,ind]

#get measurement label
feature.name<-feature[ind,2]
#clear the measurement label take () out 
feature.name<-gsub("\\(|\\)","",feature.name)

#label the measurement data
names(x.meanstd)<-feature.name

#-----------------------------------------------------------------------------
# Uses descriptive activity names to name the activities in the data set.
# Label the activity data with descriptive name
# import data: activity_labels.txt
# produce data: activity dataset with descriptive data and label

#import activities data
act<-read.table("activity_labels.txt")

#give the name for activity Y data set
y.set[,1]<-act[y.set[,1],2]

#label the activities Y dataset
names(y.set)<-"activity"

#------------------------------------------------------------------------------
# Appropriately labels the data set with descriptive names.
# produce data: dataset contain measurement,activities and subject
# 				with descriptive labels

#label the subject data
names(sub.set)<-"subject"

#get the dataset has proper label
myset<-cbind(sub.set,y.set,x.meanstd)

#------------------------------------------------------------------------------
# Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
# produce data: dataset contains rowID which identify each activity 
#               and each subject; the average of each measurement data
#               for each activity and each subject.

#get a factor data for each subject and activity
myfactor<-interaction(myset[c(1,2)])

#merge myfactor with the dataset
tidyset<-cbind(myfactor,myset)

#remove extra columns in tidy set
tidyset<-tidyset[,-which(names(tidyset)%in%c("subject","activity"))]

#get final tidyset
tidyset.final<-aggregate(tidyset,list(rowID=myfactor),FUN=mean)

#remove factor
tidyset.final<-tidyset.final[,-which(names(tidyset.final)%in%c("myfactor"))]

#export the tidy dataset
write.table(tidyset.final,"tidy_dataset.txt")
