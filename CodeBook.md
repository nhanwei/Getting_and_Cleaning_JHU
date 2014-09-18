#Study Design
============================

The experiments have been carried out with a group of 30 volunteers within an 
age bracket of 19-48 years. Each person performed six activities (WALKING, 
WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer 
and gyroscope, we captured 3-axial linear acceleration and 3-axial angular 
velocity at a constant rate of 50Hz. The experiments have been video-recorded to
label the data manually. The obtained dataset has been randomly partitioned into
two sets, where 70% of the volunteers was selected for generating the training 
data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying 
noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 
50% overlap (128 readings/window). The sensor acceleration signal, which has 
gravitational and body motion components, was separated using a Butterworth 
low-pass filter into body acceleration and gravity. The gravitational force is 
assumed to have only low frequency components, therefore a filter with 0.3 Hz 
cutoff frequency was used. From each window, a vector of features was obtained 
by calculating variables from the time and frequency domain. See 
'features_info.txt' for more details. 

============================
# Code Book
============================

* test_sub:           list of subjects in test set    
* test_X:             data frame of measurements taken in test set            
* test_y:             list of activities done by subjects in test set             
* train_sub:          list of subjects in training set    
* train_X:            data frame of measurements taken in training set            
* train_y:            list of activities done by subjects in training set             
* features:           data frame containing measurement names                
* activity_labels:    data frame containing activity names
* combined_sub:       combination of test_sub and train_sub by row
* combined_X:         combination of test_X and train_X by row
* combined_y:         combination of test_y and train_y by row
* trimmed_X:          data frame of mean and standard deviation for each measurement extracted from combined_X
* labelled_y:         replaced numbers in combined_y with activity labels
* tidy1:              combinations of combined_sub, labelled_y and trimmed_X
* tidy2:              final tidy set for submission, with the **average of each variable for each activity and each subject.**
