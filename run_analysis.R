setwd("C:/Users/200017770/Documents/coursera R files/Getting and Cleaning Data")
library(plyr)

#Preliminary work to get data (download zip contents)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
unzip(temp,list = TRUE)

#Read the data into the chosen folder
YTest <- read.table(unzip(temp, "UCI HAR Dataset/test/y_test.txt"))
XTest <- read.table(unzip(temp, "UCI HAR Dataset/test/X_test.txt"))
SubjectTest <- read.table(unzip(temp, "UCI HAR Dataset/test/subject_test.txt"))
YTrain <- read.table(unzip(temp, "UCI HAR Dataset/train/y_train.txt"))
XTrain <- read.table(unzip(temp, "UCI HAR Dataset/train/X_train.txt"))
SubjectTrain <- read.table(unzip(temp, "UCI HAR Dataset/train/subject_train.txt"))
Features <- read.table(unzip(temp, "UCI HAR Dataset/features.txt"))
Activities <- read.table(unzip(temp,"UCI HAR Dataset/activity_labels.txt"))

#Create the combined 'x' data set
XData <- rbind(XTrain,XTest)

#Create the combined 'y' data set
YData <- rbind(YTrain,YTest)

#Create the combined "subject' set
SubData <- rbind(SubjectTrain, SubjectTest)

#Find the Columns with mean or Std data
MeanSTD <- grep("-(mean|std)\\(\\)", Features[,2])

#Subset the Columns found to have desired mean/std data
XData <- XData[,MeanSTD]

#Change Column names to match new mean/std data sets
names(XData) <- Features[MeanSTD,2]

#Use the Activity names to rename items in teh data set
YData[,1] <- Activities[YData[,1],2]
names(YData) <- "activity"     #correct column name

#Now Alter teh Variabe Names
names(SubData) <- "subject"

#Create a single data set using bind
AllData <- cbind(XData,YData,SubData)

#Use current data set to make a tidy set with just averages of each activity/subject
AVGData <- ddply(AllData, .(subject,activity), function(x) colMeans(x[,1:66]))

#Write the data to a file (for submission)
write.table(AVGData, "Samsung Average Data.txt", row.name = FALSE)
