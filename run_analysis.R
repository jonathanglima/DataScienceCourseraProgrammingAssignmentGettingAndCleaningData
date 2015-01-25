#defining the working directory to the script's directory
setwd(dirname(sys.frame(1)$ofile))

# Step1: Merges the training and the test sets to create one data set.
# reading the train dataset, if it doesn't exist
if (!exists("train")) {
  train <- read.table("dataset/train/X_train.txt", sep="", header=FALSE)
  train[562] <- read.table("dataset/train/Y_train.txt", sep="", header=FALSE)
  train[563] <- read.table("dataset/train/subject_train.txt", sep="", header=FALSE)
}

# reading the test dataset, if it doesn't exist
if (!exists("test")) {
  test <- read.table("dataset/test/X_test.txt", sep="", header=FALSE)
  test[562] <- read.table("dataset/test/Y_test.txt", sep="", header=FALSE)
  test[563] <- read.table("dataset/test/subject_test.txt", sep="", header=FALSE)
}

# Binding Tests and Trains, if not already bound
if (!exists("bindedData")) {
  bindedData <- rbind(train, test)
}

# Step2: Extracts only the measurements on the mean and standard deviation for each measurement. 
# reading the activity labels and naming the columns, if it doesn't exist
if (!exists("activityLabels")) {
  activityLabels <- read.table("dataset/activity_labels.txt", sep="", header=FALSE, col.names = c("activityId", "activity"))
}

# reading the features and naming the columns, if it doesn't exist
if (!exists("features")) {
  features <- read.table("dataset/features.txt", sep="", header=FALSE, col.names = c("featureId", "feature"))
  features$feature = gsub(',', '-', gsub('[-()]', '', gsub('-mean', 'Mean', gsub('-std', 'Std', features$feature))))
}

# Index of columns of Std dv. and Mean, if not already selected
if (!exists("selectedColumns")) {
  selectedColumns <- grep(".*Std.*|.*Mean.*", features$feature)
  features <- features[selectedColumns,]
  selectedColumns <- c(selectedColumns, 562, 563)
  bindedData <- bindedData[,selectedColumns]
  # Step 4: Appropriately labels the data set with descriptive variable names. 
  colnames(bindedData) <- c(features$feature, "Activity", "Subject")
  # Step 3: Uses descriptive activity names to name the activities in the data set
  bindedData$Activity <- factor(bindedData$Activity, levels=activityLabels$activityId, labels=activityLabels$activity)
}

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- aggregate(bindedData, by=list(Activity = bindedData$Activity, Subject=bindedData$Subject), mean)
tidyData[,90] = NULL
tidyData[,89] = NULL
write.table(tidyData, "tidy.txt", sep="\t", row.name=FALSE)