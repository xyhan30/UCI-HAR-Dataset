# Getting and Cleaning Data - Course Project
# 1. Load required package
library(dplyr)
# 2. Read activity labels and feature names
activity_labels <- read.table("activity_labels.txt",
                              header = FALSE,
                              col.names = c("activity_id", "activity"))
features <- read.table("features.txt",
                       header = FALSE,
                       col.names = c("feature_id", "feature"),
                       stringsAsFactors = FALSE)
# 3. Identify measurements on the mean and standard deviation
selected_features <- grep("-(mean|std)\\(\\)", features$feature)
selected_feature_names <- features$feature[selected_features]
# 4. Read training data
train_x <- read.table("train/X_train.txt")
train_y <- read.table("train/y_train.txt")
train_subject <- read.table("train/subject_train.txt")
# 5. Read test data
test_x <- read.table("test/X_test.txt")
test_y <- read.table("test/y_test.txt")
test_subject <- read.table("test/subject_test.txt")
# 6. Extract mean and standard deviation measurements
train_x <- train_x[, selected_features]
test_x <- test_x[, selected_features]
# 7. Assign descriptive variable names
names(train_x) <- selected_feature_names
names(test_x) <- selected_feature_names
# 8. Combine training and test data
train_data <- cbind(train_subject, train_y, train_x)
test_data <- cbind(test_subject, test_y, test_x)
names(train_data)[1:2] <- c("subject", "activity_id")
names(test_data)[1:2] <- c("subject", "activity_id")
all_data <- bind_rows(train_data, test_data)
# 9. Replace activity IDs with descriptive activity names
all_data <- all_data %>%
  left_join(activity_labels, by = c("activity_id" = "activity_id")) %>%
  select(subject, activity, everything(), -activity_id)
# 10. Create a second independent tidy data set
tidy_data <- all_data %>%
  group_by(subject, activity) %>%
  summarise(across(where(is.numeric), mean), .groups = "drop")
# 11. Write the tidy data set to a text file
write.table(tidy_data,
            "tidydata.txt",
            row.names = FALSE)
# 12. Display the result
dim(tidy_data)
head(tidy_data)