## Set the working directory and read all the necessary table
setwd("~/Documents/Coursera Data Science/Getting and Cleaning Data/UCI HAR Dataset/")
testData <- read.table("test/X_test.txt")
trainData <- read.table("train/X_train.txt")
testLabels <- read.table("test/y_test.txt")
trainLabels <- read.table("train/y_train.txt")
trainSubject <- read.table("train/subject_train.txt")
testSubject <- read.table("test/subject_test.txt")
actLabels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

## Combine test and training data
allData <- rbind(trainData, testData)
allLabels <- rbind(trainLabels, testLabels)
allSubject <- rbind(trainSubject, testSubject)

## Find the columns associated with the mean values
meanDataInd <- grep("mean()", features$V2, ignore.case = TRUE)
meanData <- allData[, meanDataInd]
meanNames <- features[meanDataInd,2]

## Find the columns associated with the standard deviation values
stdDataInd <- grep("std()", features$V2, ignore.case = TRUE)
stdData <- allData[, stdDataInd]
stdNames <- features[stdDataInd,2]

## Change labels from numeric values to readable activities 
txtLabels <- as.data.frame(actLabels$V2[as.numeric(allLabels$V1)])

## Combine subject, activity, mean and satndard deviation data to one table
finalData <- cbind(allSubject, txtLabels, meanData, stdData)
## Name the columns appropriately
colnames(finalData) <- c("Subject", "Activity", as.character(meanNames)
                         , as.character(stdNames))

## Find the mean for each subject and activity
cleanData <- melt(finalData, id = c("Subject", "Activity"))
cleanData2 <- dcast(cleanData, Subject + Activity ~ variable, mean)

## Write to txt file
write.table(cleanData2, "CleanData.txt", row.names = FALSE)