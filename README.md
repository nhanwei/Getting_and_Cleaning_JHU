#Getting and Cleaning Data Course Project
=========================================

This is a markdown document to explain the scripts written to clean and get a tidy data.

=========================================
##Introduction
=========================================

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked here are data collected from the accelerometers from the Samsung Galaxy S smartphone while the subjects were made to do certain activities such as walking, standing and sitting. 

**Dataset can be downloaded from this link:**

[Click here to Download](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

**Instructions for the final tidy data:**

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

=========================================
##Script Breakdown
=========================================

*It is my habit to comment and write down the dimensions of each dataset. Thus you will see many "# dim 2947 X 1" at the back of some lines.*

**Loading libraries namely "tidyr", "dplyr" and "plyr".**

* library(tidyr)
* library(dplyr)
* library(plyr)

**Setting the working directory.**

* setwd("./Downloads/UCI HAR Dataset")

**Reading in data from training set, test set, features and activity_labels. (nothing special)**

* test_sub <- read.table("./test/subject_test.txt")       # dim 2947 X 1
* test_X <- read.table("./test/X_test.txt")               # dim 2947 X 561
* test_y <- read.table("./test/y_test.txt")               # dim 2947 X 1
* train_sub <- read.table("./train/subject_train.txt")    # dim 7352 X 1
* train_X <- read.table("./train/X_train.txt")            # dim 7352 X 561
* train_y <- read.table("./train/y_train.txt")            # dim 7352 X 1
* features <- read.table("./features.txt")                # dim 561 X 2
* activity_labels <- read.table("./activity_labels.txt")  # dim 6 X 2

**Combining data from test and training set using the rbind command. (part 1)**

* combined_sub <- rbind(test_sub, train_sub)              # dim 10299 X 1
* combined_X <- rbind(test_X, train_X)                    # dim 10299 X 561
* combined_y <- rbind(test_y, train_y)                    # dim 10299 X 1

**Giving proper headings for the measurements / subjects for the X and subject dataset. (part 4)**

* names(combined_X) <- features$V2
* names(combined_sub) <- "subject"

**Extracting measurements on mean and std for each measurements using the select command from dplyr library. (part 2)**

* trimmed_X <- select(combined_X, matches("-mean()"), matches("-std()"), 
                    -matches("meanFreq"))               # dim 10299 X 66

**Creating a new column called "activity" by comparing combined_y$V1 with the activity_labels (part 3). We only keep the "activity" column here.**

* labelled_y <- mutate(combined_y, activity = activity_labels$V2[combined_y$V1])  
* labelled_y <- select(labelled_y, activity)              # dim 10299 X 1

**1st tidy dataset obtained by combining 3 datasets as shown below using cbind command**

* tidy1 <- cbind(combined_sub, labelled_y, trimmed_X)     # dim 10299 X 68

**2nd tidy dataset, also our final tidy data. I performed the ddply command from plyr library. I set "subject" and "activity" to be the variables to split by. numcolwise(mean) is an argument to apply a function (mean in this case) to every column that we know is numeric.** 

* tidy2 <- ddply(tidy1, .(subject, activity), numcolwise(mean))     # dim 180 X 68

**Saving a copy in working directory as tidy2.txt**

* write.table(tidy2, "./tidy2.txt", row.name=FALSE)

#The End
