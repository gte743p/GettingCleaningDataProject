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