## run_analysis.R
library(reshape2)
### Create data directory to store data downloaded
if(!file.exists("./data")) {
  dir.create("./data")
}

### Download and unzip file
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataUrl, destfile = "./data/data.zip")
unzip("./data/data.zip", exdir = "./data")

## 1. Merges the training and the test sets to create one data set

### Getting data information
activities_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
features_labels <- read.table("./data/UCI HAR Dataset/features.txt")

### Reading Test Data Files
x_test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test_data <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
subject_test_data <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

### Reading Train Data Files
x_train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train_data <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train_data <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

### Creating Data Sets
x_data_set <- rbind(x_test_data, x_train_data)
y_data_set <- rbind(y_test_data, y_train_data)
s_data_set <- rbind(subject_test_data, subject_train_data)

### Create final data set
result_data_set <- cbind(s_data_set, y_data_set, x_data_set)
colnames(result_data_set) <- c("subject", "activity", features_labels$V2)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement
### Get column names
names <- colnames(result_data_set)

### Filter column names by regular expression
column_filtered <- grep("std|mean|activity|subject", names, value = TRUE)

### Updated data sets to include just columns filtered
result_data_set <- result_data_set[, column_filtered]

## 3. Uses descriptive activity names to name the activities in the data set
result_data_set$activity <- factor(result_data_set$activity, levels = activities_labels$V1, labels = activities_labels$V2)

## 4. Appropriately labels the data set with descriptive variable names.
names <- colnames(result_data_set)

names <- gsub("mean\\(\\)", "Mean", names)
names <- gsub("std\\(\\)", "Std", names)

colnames(result_data_set) <- names

## 5. From the data set in step 4, creates a second, independent tidy data set with average of each variable for each activity and each subject.
mean_std_columns <- grep("(Std|Mean)", colnames(result_data_set), value = TRUE)
melt_dataset <- melt(result_data_set, id = c("subject", "activity"), measure.vars = mean_std_columns)
final_tidy_dataset <- dcast(melt_dataset, subject + activity ~ variable, mean)
write.table(final_tidy_dataset, "./tidy_data_set.txt", row.names = FALSE)



