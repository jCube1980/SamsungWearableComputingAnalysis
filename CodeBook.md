
The raw dataset includes the following files:

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

To summarize, X_test and X_train contain the data of all features in features.txt. The subjects involved and the activities they performed are listed in subject_test.txt, subject_train.txt and y_test.txt, y_train.txt respectively.

Our goal is to merge the training and test data and focus on the mean and standard deviation measures to drive some summary analysis figures; specifically mean of the relevant measures grouped by subject and activity. 

Towards this following steps were performed. 

# OBJECTIVE 1 - Merges the training and the test sets to create one data set.
#STEPS
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


# OBJECTIVE 2 - Extract only the measurements on the mean and standard deviation for each measurement.

This has been done by using a simple search of all the features for the words mean or std. All features that found a match were included in the study. It may be noted that all features that have the words "mean" or "std" may not be of interest. Optimizing the regular expression used in the grep will help provide cleaner data, if needed. As is, 79 features have been included. 

# OBJECTIVE 3 - Uses descriptive activity names to name the activities in the data set

The activity_labels.txt file contains activity names and their corresponding "levels". This information was used to define an "activity" column with human readable labels using factor()

# OBJECTIVE 4 - Appropriately labels the data set with descriptive variable names.
This objective has been covered in steps 1.1D and 1.2C by specifying col.names from features.

# OBJECTIVE 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The melt and dcast functions from the reshape2 package have been employed to meet this objective. 
The melt function is used to transform the wide data to long data by "swinging down" the columns to variable-value pairs with "subject" and "activity" as id fields.
Once the data has been melted (made long), the dcast function is used to swing up the variables using "subject" and "activity" as id fields and the "mean" aggregate function to compute the required averages.


