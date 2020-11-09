## Week 3 - Getting and Cleanind Data Course Project

### Data used for project

- [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## How Script Works

1. Script downloads the .zip file from the URL stated above, and unzips it in current directory.
2. Script reads data from different files from the zip folder and create different data sets according to each variable (x, y or subject)
3. All three datasets are merged into a single data set and its columns are renamed
4. Scripts exatracts only columns that have information about mean or standard deviation
5. Script updated column names of data set to have a more descriptive name for its analysis
6. Script creates second data set, which only contains mean values of each mean and standard deviation variable in dataset
7. Script creates file tidy_data_set.txt, which store the final data set.
