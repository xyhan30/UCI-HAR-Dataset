# Getting and Cleaning Data - Course Project
## Overview
This project is part of the Getting and Cleaning Data course.
The purpose is to prepare a tidy dataset from the Human Activity Recognition Using Smartphones Dataset.
## Files
- run_analysis.R: R script used to clean and transform the original data.
- CodeBook.md: Describes the variables and data transformations.
- tidydata.txt: Final tidy dataset containing the average of each measurement for each subject and activity.
## How to Run
1. Download and unzip the UCI HAR Dataset.
2. Set the working directory to the UCI HAR Dataset folder.
3. Run run_analysis.R in RStudio.
The script generates tidydata.txt.
## Data Description
The final dataset contains 180 rows and 68 columns.
Each row represents one subject performing one activity. The measurement columns contain the average values of the selected mean and standard deviation measurements.
## Activities
The dataset includes six activities:
- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING