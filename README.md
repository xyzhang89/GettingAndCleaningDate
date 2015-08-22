# GettingAndCleaningDate
## Introduction
This repo contains my course project for [Getting And Cleaning Data](https://class.coursera.org/getdata-031) course which is part of [Data Science Specialization](https://www.coursera.org/specialization/jhudatascience/1) provided by [Coursera](https://www.coursera.org).

## Analysis
The code in the script `run_analysis.R` contains the following sections:

1. Generating Selector
2. Reading and Merging Data
3. Grouping Data and Calculating Mean
4. Converting Wide Tidy Data to Narrow Tidy Data
5. Writing Output Data to a TXT File 

The data for this project is downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ). The code can be run as long as the folder `UCI HAR Dataset` is in the working directory

###Generating Selector
In this project, only the measurements on the mean and standard deviation for each measurement are concerned. Generating a selector before reading data will helps improve the efficiency in reading data especially when the dataset is large. In this case, we will read 79 columns instead of 561 columns after generating a selector.

First, read the `features.txt` file which determines what columns of the large dataset are needed. Second, use `grep()` to select the entries that include mean() and std() at the end, or include entries with mean in an earlier part of the name as well. Also, save the names for future use of generating data frame. Finally, generate lists composed of "numeric" and "NULL" with distribution determined by the features, the list will be designed to the argument `colClasses`in `read.table()`.

###Reading and Merging Data
First, read the `X_train.txt` and `X_test.text` by `read.table()` with argument `colClasses` defined as the selectors generated earlier to read the only columns needed. Then, read the files `subject_train.txt`, `Y_train.txt`, `subject_test.txt` and `Y_test.txt` into tables. Also, name the tables after reading them for further convienience. Finally, use `cbind()` and `rbind()` to merge the data to a new data frame.
###Grouping Data and Calculating Mean
First, read the `activity_labels.txt` file to get the activity labels. Second, replace the numbers in the activity label with the activity names. Finally, group the data and calculate the average of each variable for each activity and each subject using `group_by()` and `summrise_each()` from the library `dplyr`. 
###Converting Wide Tidy Data to Narrow Tidy Data
From above, a wide tidy dataset with means is obtained. To get a long/narrow tidy dataset, `melt()` is applied.
###Writing Output Data to a TXT File
The final output file `data_tidy.txt` is created by `write.table()` using row.name=FALSE.


