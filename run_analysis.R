## OBJECTIVE 1 - Merges the training and the test sets to create one data set.

## STEPS
        #1 Read test data
                #A) Read features.txt (This forms the columns of the data frame)
                #B) Read test\subject_test.txt
                #C) Read test\y.txt
                #D) Read test\X.txt
                #E) cbind subject, y and df

        #2 Read train data
                #A) Read train\subject_train.txt
                #B) Read train\y.txt
                #C) Read train\X.txt
                #D) cbind subject, y and df
        #3 Rbind testdf, traindf

library(reshape2)

#1.1A
features <- read.table(file = "UCI HAR Dataset/features.txt", header = FALSE)

#1.1B
testSubject <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = c("subject"))

#1.1C
testy <- read.table(file = "UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = c("activity"))

#1.1D
testX <- read.table(file = "UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = features[,2])

#1.1E
testdf <- cbind(testSubject, testy, testX)

#1.2A
trainSubject <- read.table(file = "UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = c("subject"))

#1.2B
trainy <- read.table(file = "UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = c("activity"))

#1.2C
trainX <- read.table(file = "UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = features[,2])

#1.2D
traindf <- cbind(trainSubject, trainy, trainX)

#1.3
df <- rbind(testdf, traindf)


## OBJECTIVE 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
wanted <- grep(pattern = "mean|std", x = names(df), value = FALSE)
df <- df[,c(1, 2, wanted)]

## OBJECTIVE 3 - Uses descriptive activity names to name the activities in the data set
activities <- read.table(file = "UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names = c("num", "activity"))
df$activity <- factor(x = df$activity, levels = activities$num, labels = activities$activity)

## OBJECTIVE 4 - Appropriately labels the data set with descriptive variable names.
# COvered in 1.1D and 1.2C (col.names)

## OBJECTIVE 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

df1 <- melt(df, id.vars = c(1,2))
df2 <- dcast(df1, subject + activity ~ variable, mean)

