CodeBook

----------------------------------------------------

This codebook provides details on the variables for data2 and avg_data (which is derived from data2).

#data2

This dataset is the merged test and train data objects converted to long format.

##Variables:
- subject_id is a numerical code identifying each experiment participant
- activity_code is a numerical code (1 through 6) identifying the 6 activities participants were asked to perform
- activity_descr is a character string which provides generic activity descriptions for the 6 activities
- dataset_id is an optional character field which identifies which records were split into the training subset by the data originators and which were split into the testing subset
- measurement is a description of each of the measured velocity and acceleration attributes. Additional information (and how to interpret units) can be found in the original data documentation file "features_info.txt".
- value represents the normalized measured value of each of the described measures. Additional information (and how to interpret units) can be found in the original data documentation file "features_info.txt".

#avg_data

This data set is a subset of the variables in data2 and provides the average of each variable for each activity and each subject.

##Variables:
- subject_id is a numerical code identifying each experiment participant
- activity_descr is a character string which provides generic activity descriptions for the 6 activities
- measurement is a description of each of the measured velocity and acceleration attributes. Additional information (and how to interpret units) can be found in the original data documentation file "features_info.txt".
- mean_msrmnt represents the average of the normalized measured value of each of the described measures. Additional information (and how to interpret units) can be found in the original data documentation file "features_info.txt".