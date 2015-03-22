#Get and Clean Data repo

This repo serves to retrieve, manipulate, and summarize data used in a Human Activity Recognition Using Smartphones Data Set. All of the steps are completed using run_analysis.R

The original dataset and relevant details about the original data can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This document provides (minimal) details on the original data, as well as information on the variables and steps within run_analysis.R, and resulting derived datasets.

Information about the variables found in the data2 dataset and avg_data can be found in CodeBook.md

#Original data

Data on Human Activity Recognition using Smartphones were retrieved from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. Additional details can be found at the dataset's website listed above. 

##Steps 1 and 2 of run_analysis.R simply retrieve the data objects from the online source and read those objects into R. If you are running run_analysis from this repo, you can skip Step 1 as the original data and documentation are already downloaded in the /data folder.

###Step 2 reads the data into R creates the following R data objects - object names are those used in run_analysis.R:

Object Name | Original data name | End Use |
activity.lbls|activity_labels.txt|descriptive labels of activities|
features|features.txt|variable names for test and train data|
test.data|X_test.txt|test.data values|
test.lbls|y_test.txt|provides activity code for measurements in test.data|
subject.test|subject_test.txt|identifies test.data participants, corresponds to rows|
train.data|X_train.txt|train.data values|
train.lbls|y_train.txt|provides activity code for measurements in train.data|
subject.train|subject_train.txt|identifies train data participants|
[Object Table]

[table][Object Table]

##Steps 3 and 4 stitch the objects together resulting in a single dataset (data: including test and train constituents) that is then gathered into a tidy dataset (data2).

- features is used as the descriptive variables for test.data and train.data, becoming the column headers.
- test.lbls and train.lbls are combined with activity.lbls so that activity_codes and descriptive activities (activity_descr) variables can be applied to the respective datasets.
- subject.test and subject.train are joined with their respective datasets such that a subject_id variable is available in the resulting dataset
- a dataset_id variable is also applied to both the test and train datasets. This is an optional step, but would allow separate handling of these data subsets if desired.

Once these objects are combined, they are merged into a dataset (data) containing both the original test and train datasets. This dataset is then converted to a long format (data2) to allow for further summarization.

#Derived datasets
##Step 5 creates two derived datasets:

- msrmnt_smry: provides only the measurements on the mean and standard deviation for each measurement.
- avg_data: is an independent tidy data set with the average of each variable for each activity and each subject.

As stated above, information about the variables found in the data2 dataset and avg_data can be found in CodeBook.md