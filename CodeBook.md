# CodeBook
## Project: Getting and Cleaning Data Course Project
### 1. Original Dataset
The original dataset is the Human Activity Recognition Using Smartphones Dataset (UCI HAR Dataset).
The data were collected from 30 volunteers performing six activities while wearing a smartphone on their waist.
### 2. Source Files
The analysis uses the following files:
- train/X_train.txt
- train/y_train.txt
- train/subject_train.txt
- test/X_test.txt
- test/y_test.txt
- test/subject_test.txt
- features.txt
- activity_labels.txt
### 3. Data Transformation
The following steps were performed:
1. Training and test datasets were combined into one dataset.
2. Only measurements containing mean() or std() in their feature names were extracted.
3. Activity IDs were replaced with descriptive activity names using activity_labels.txt.
4. Descriptive variable names from features.txt were assigned to the measurement columns.
5. The dataset was grouped by subject and activity.
6. The average of each measurement was calculated for each subject and activity combination.
### 4. Variables
The final tidy dataset contains 180 rows and 68 columns.
- subject: Identifier of the participant (1–30).
- activity: Name of the activity performed.
- The remaining 66 columns: Average values of the selected mean and standard deviation measurements.
### 5. Activity Labels
The six activities are:
- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING
### 6. Measurement Variables
The measurement variables are selected from the original smartphone sensor measurements.
They include mean and standard deviation measurements from:
- Time-domain body acceleration
- Gravity acceleration
- Body acceleration jerk
- Body gyroscope
- Body gyroscope jerk
- Magnitude measurements
- Frequency-domain measurements
The original feature names are retained to describe the measurements.
### 7. Output
The final tidy dataset is saved as tidydata.txt.
Each row represents one subject performing one activity, with the average of each selected measurement.