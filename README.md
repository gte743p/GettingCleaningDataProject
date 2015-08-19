---
title: "Getting and Cleaning Data Course Project README"
output: html_document
---

## Project Description
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project: 

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

## Description of run_analysis.R
Data in the above link is from experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (Laying, Sitting, Standing, Walking, Walking Downstairs, Walking Upstairs) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the experimenters captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.  Data collected from the Samsung Galaxy S II accelerometer and gyroscope are referred to as "features" within the data set.

run_analysis.R takes the features data from these experiments and transforms it into a tidy data set, consisting of the average values of selected features by test subject and activity. It is assumed that the folder containing run_analysis.R already contains the files needed to create the tidy data set:
 
 * features.txt
 * activity_labels.txt
 * test/X_test.txt
 * test/y_test.txt
 * test/subject_test.txt
 * train/X_train.txt
 * train/y_train.txt
 * train/subject_train.txt

Features included in the final tidy data set consist of all those from the original data set that contain the phrase "mean" or "std", representing measurement means and standard deviations:

 * mean(): Mean value
 * std(): Standard deviation

The features included in the final tidy data set also included "meanFreq" measures:

 * meanFreq(): Weighted average of the frequency components to obtain a mean frequency

## Code for run_analysis.R

```{r}
run_analysis <- function() {
      
      ## load dplyr and reshape2 libraries
      library(dplyr)
      library(reshape2)
      
      ## read features and activity labels
      features <- read.table("features.txt")
      activity_labels <- read.table("activity_labels.txt")
      
      ## read test data
      testX <- read.table("./test/X_test.txt")
      testY <- read.table("./test/y_test.txt")
      testSubj <- read.table("./test/subject_test.txt")
      
      ## read training data
      trainX <- read.table("./train/X_train.txt")
      trainY <- read.table("./train/y_train.txt")
      trainSubj <- read.table("./train/subject_train.txt")
      
      ## combine data
      testSet <- cbind(testSubj, testY, testX)
      trainSet <- cbind(trainSubj, trainY, trainX)
      allData <- rbind(trainSet, testSet)
      
      ## replace activity id with name
      allData[, 2] <- activity_labels[allData[ ,2], 2]
      features <- as.character(features[, 2])
      
      ## replace abbreviated terms in feature names
      features <- gsub("Acc", "Acceleration", features)
      features <- gsub("Gyro", "Gyroscope", features)
      features <- gsub("Mag", "Magnitude", features)
      features <- gsub("BodyBody", "Body", features)
      
      ## set column names to features
      colnames(allData) <- c("subject", "activity", features)
      
      ## subset data to get only columns with "mean()" and "std()"
      meanCols <- grep("mean()", features)
      stdCols <- grep("std()", features)
      meanStdCols <- unique(c(meanCols, stdCols))
      features <- features[meanStdCols]
      featuresCols <- meanStdCols + 2
      allData <- allData[, c(1, 2, featuresCols)]
      allData <- arrange(allData, subject, activity)
      
      ## melt data features
      meltedDF <- melt(allData, id = c("subject", "activity"), measure.vars = features)
      
      # recast data by taking mean of each feature by subject & activity
      returnData <- dcast(meltedDF, subject + activity ~ variable, mean)
      
      ## group_by and summarise_each also works
      #smallData <- group_by(allData, subject, activity)
      #returnData <- summarise_each(smallData, funs(mean))
      
      write.table(returnData, file = "output.txt", row.names = FALSE)
      returnData
}
```