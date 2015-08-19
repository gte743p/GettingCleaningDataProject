---
title: "Getting and Cleaning Data Course Project Codebook"
output: html_document
---

## Dataset Columns

**subject** -
Unique identifier taking values 1 through 30 indicating each subject participating in the experiment

**activity** -
Description of activity being performed by test subject, taking one of 6 values:  Laying, Sitting, Standing, Walking, Walking Downstairs, Walking Upstairs

**all remaining columns** -
Description of what is being measured by the Samsung Galaxy SII accelerometer or gyroscope. All numerical values represent the mean of all measurements taken for the subject/activity pair, for each of the features described below.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcceleration-XYZ and tGyroscope-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. The acceleration signal was then separated into body and gravity acceleration signals (tBodyAcceleration-XYZ and tGravityAcceleration-XYZ). 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAcccelerationJerk-XYZ and tBodyGyroscopeJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccelerationMagnitude, tGravityAccelerationMagnitude, tBodyAccelerationJerkMagnitude, tBodyGyroscopeMagnitude, tBodyGyroscopeJerkMagnitude). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcceleration-XYZ, fBodyAccelerationJerk-XYZ, fBodyGyroscope-XYZ, fBodyAccelerationJerkMagnitude, fBodyGyroscopeMagnitude, fBodyGyroscopeJerkMagnitude. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

 - tBodyAcceleration-XYZ
 - tGravityAcceleration-XYZ
 - tBodyAccelerationJerk-XYZ
 - tBodyGyroscope-XYZ
 - tBodyGyroscopeJerk-XYZ
 - tBodyAccelerationMagnitude
 - tGravityAccelerationMagnitude
 - tBodyAccelerationJerkMagnitude
 - tBodyGyroscopeMagnitude
 - tBodyGyroscopeJerkMagnitude
 - fBodyAcceleration-XYZ
 - fBodyAccelerationJerk-XYZ
 - fBodyGyroscope-XYZ
 - fBodyAccelerationMagnitude
 - fBodyAccelerationJerkMagnitude
 - fBodyGyroscopeMagnitude
 - fBodyGyroscopeJerkMagnitude

The set of variables that were estimated from these signals are: 

 - mean(): Mean value
 - std(): Standard deviation
 - meanFreq(): Weighted average of the frequency components to obtain a mean frequency

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

 - gravityMean
 - tBodyAccelerationMean
 - tBodyAccelerationJerkMean
 - tBodyGyroscopeMean
 - tBodyGyroscopeJerkMean