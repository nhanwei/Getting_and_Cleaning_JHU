library(tidyr)
library(dplyr)
library(plyr)

setwd("./Downloads/UCI HAR Dataset")

# reading in data
test_sub <- read.table("./test/subject_test.txt")       # dim 2947 X 1
test_X <- read.table("./test/X_test.txt")               # dim 2947 X 561
test_y <- read.table("./test/y_test.txt")               # dim 2947 X 1

train_sub <- read.table("./train/subject_train.txt")    # dim 7352 X 1
train_X <- read.table("./train/X_train.txt")            # dim 7352 X 561
train_y <- read.table("./train/y_train.txt")            # dim 7352 X 1

features <- read.table("./features.txt")                # dim 561 X 2
activity_labels <- read.table("./activity_labels.txt")  # dim 6 X 2

# combining data from test and training set (part 1)
combined_sub <- rbind(test_sub, train_sub)              # dim 10299 X 1
combined_X <- rbind(test_X, train_X)                    # dim 10299 X 561
combined_y <- rbind(test_y, train_y)                    # dim 10299 X 1

# giving proper headings for the X and sub dataset (part 4)
names(combined_X) <- features$V2

names(combined_sub) <- "subject"

# extracting measurements on mean and std for each measurements (part 2)
trimmed_X <- select(combined_X, matches("-mean()"), matches("-std()"), 
                    -matches("meanFreq"))               # dim 10299 X 66

# substituting the number by the activity labels (part 3)
labelled_y <- mutate(combined_y, activity = activity_labels$V2[combined_y$V1])  
labelled_y <- select(labelled_y, activity)              # dim 10299 X 1

# 1st tidy dataset
tidy1 <- cbind(combined_sub, labelled_y, trimmed_X)     # dim 10299 X 68

# 2nd tidy dataset
tidy2 <- ddply(tidy1, .(subject, activity), numcolwise(mean))     # dim 180 * 68
write.table(tidy2, "./tidy2.txt", row.name=FALSE)