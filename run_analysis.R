
library(dplyr)
library(tidyr)


####STEP 1 - RETRIEVE DATA (OPTIONAL)
###Data from the URL below is already available in the "data" folder of this repo

#download the zipped project dataset
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, destfile = "./x.zip")

#create a directory (folder) to unzip to
dir.create("data")

#unzip the downloaded data
unzip("./x.zip", exdir = "./data")

####STEP 2: READ DATA INTO R
#create a path to the data folder
path <- "./data/UCI HAR Dataset/"

#Read in descriptions
activity.lbls <- read.table(file.path(path, "activity_labels.txt"), header=F)
features <- read.table(file.path(path, "features.txt"), header=F)
 
#Read in test data  
test.data <- read.table(file.path(path, "/test/X_test.txt"), header=F)
test.lbls <- read.table(file.path(path, "/test/y_test.txt"), header=F)
subject.test <- read.table(file.path(path, "/test/subject_test.txt"), header=F)

#Read in train data
train.data <- read.table(file.path(path, "/train/X_train.txt"), header=F)
train.lbls <- read.table(file.path(path, "/train/y_train.txt"), header=F)
subject.train <- read.table(file.path(path, "/train/subject_train.txt"), header=F)

####STEP 3: ADD VARIABLE NAMES AND OTHER DESCRIPTIVE VARIABLES
#apply features as descriptive variable names for both test and train datasets
colnames(test.data) <- features$V2
colnames(train.data) <- features$V2

#join test and train labels with activity labels to permit more descriptive naming
test.lbls <- full_join(test.lbls, activity.lbls, by = "V1")
train.lbls <- full_join(train.lbls, activity.lbls, by = "V1")

#add variable names to test and train labels tables and subject tables
colnames(test.lbls) <- c("activity_code", "activity_descr")
colnames(train.lbls) <- c("activity_code", "activity_descr")

colnames(subject.test) <- "subject_id"
colnames(subject.train) <- "subject_id"

#add descriptive activity names to test and train datasets
test <- cbind(test.lbls, test.data)
train <- cbind(train.lbls, train.data)

#add subject identification label to test and train datasets
test <- cbind(subject.test, test)
train <- cbind(subject.train, train)

#optional: add dataset identification label to distibguish test and train datasets
test$dataset_id <- "test"
train$dataset_id <- "train"

#clean workspace
rm(activity.lbls, features, subject.test, subject.train, test.data, test.lbls,
   train.data, train.lbls)

####STEP 4: MERGE DATASETS AND CREATE NEW TIDY DATASET
#merge test and train datasets
data <- rbind(test, train)

#gather the data
data2 <- gather(data, measurement, value, -subject_id, -activity_code, -activity_descr, -dataset_id)

####STEP 5: CREATE DERIVED DATASETS
#extract mean and standard deviation for each attribute measurement
msrmnt_smry <- data2 %>%
  group_by(measurement) %>%
  summarise(mean=mean(value), sd=sd(value))

#create independent tidy data set with the average of each variable for each activity and each subject.
avg_data <- data2 %>%
  select(subject_id, activity_descr, measurement, value) %>%
  group_by(subject_id, activity_descr, measurement) %>%
  summarise(mean_msrmnt = mean(value))

dir.create("./output")
write.table(avg_data, "./output/avg_data.txt", sep = ",", row.names=FALSE)

#to read the avg_data.txt file in from the output folder of the repo, use this line of code:
avg_data <- read.table("./output/avg_data.txt", sep = ",", header = TRUE)
