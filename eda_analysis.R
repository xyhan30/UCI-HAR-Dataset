# ==========================================
# UCI Human Activity Recognition
# Exploratory Data Analysis (EDA)
# ==========================================
# 1. Set working directory
setwd("F:/UCI HAR Dataset")
# 2. Load required package
library(dplyr)
library(ggplot2)
# 3. Read tidy dataset
tidy_data <- read.table(
  "tidydata.txt",
  header = TRUE
)
# 4. Check dataset structure
dim(tidy_data)
str(tidy_data)
# 5. Check first few rows
head(tidy_data)
# 6. Check activity distribution
table(tidy_data$activity)
# 7. Visualize activity distribution
activity_counts <- as.data.frame(
  table(tidy_data$activity)
)
names(activity_counts) <- c("Activity", "Count")
barplot(
  activity_counts$Count,
  names.arg = activity_counts$Activity,
  horiz = TRUE,
  las = 1,
  col = "steelblue",
  xlab = "Number of Observations",
  main = "Distribution of Human Activities"
)
# 8. Compare body acceleration across activities
activity_summary <- tidy_data %>%
  group_by(activity) %>%
  summarise(
    mean_acc_X = mean(tBodyAcc.mean...X),
    sd_acc_X = sd(tBodyAcc.mean...X),
    .groups = "drop"
  )
print(activity_summary)
# 9. Boxplot of body acceleration by activity
boxplot(
  tBodyAcc.mean...X ~ activity,
  data = tidy_data,
  las = 2,
  col = "lightblue",
  xlab = "Activity",
  ylab = "Mean Body Acceleration (X-axis)",
  main = "Body Acceleration Across Different Activities"
)
# 10. Compare mean body acceleration across activities
ggplot(activity_summary, aes(x = activity, y = mean_acc_X)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Average Body Acceleration by Activity",
    x = "Activity",
    y = "Average Body Acceleration (X-axis)"
  ) +
  theme_minimal()
# 11. Calculate median body acceleration by activity
median_summary <- tidy_data %>%
  group_by(activity) %>%
  summarise(
    median_acc_X = median(tBodyAcc.mean...X),
    .groups = "drop"
  )
print(median_summary)
# 12. Visualize median body acceleration by activity
ggplot(median_summary, aes(x = activity, y = median_acc_X)) +
  geom_col(fill = "darkorange") +
  coord_flip() +
  labs(
    title = "Median Body Acceleration by Activity",
    x = "Activity",
    y = "Median Body Acceleration (X-axis)"
  ) +
  theme_minimal()
# 13. Calculate acceleration range by activity
range_summary <- tidy_data %>%
  group_by(activity) %>%
  summarise(
    min_acc_X = min(tBodyAcc.mean...X),
    max_acc_X = max(tBodyAcc.mean...X),
    range_acc_X = max_acc_X - min_acc_X,
    .groups = "drop"
  )
print(range_summary)
# 14. Compare standard deviation across activities
sd_summary <- tidy_data %>%
  group_by(activity) %>%
  summarise(
    sd_acc_X = sd(tBodyAcc.mean...X),
    .groups = "drop"
  )
print(sd_summary)
# 15. Visualize standard deviation by activity
ggplot(sd_summary, aes(x = activity, y = sd_acc_X)) +
  geom_col(fill = "seagreen") +
  coord_flip() +
  labs(
    title = "Standard Deviation of Body Acceleration by Activity",
    x = "Activity",
    y = "Standard Deviation (X-axis)"
  ) +
  theme_minimal()
# 16. Select numerical features for PCA
pca_data <- tidy_data %>%
  select(where(is.numeric)) %>%
  select(-subject)
dim(pca_data)
# 17. Standardize numerical features
pca_scaled <- scale(pca_data)
dim(pca_scaled)
# 18. Perform Principal Component Analysis
pca_result <- prcomp(
  pca_scaled,
  center = FALSE,
  scale. = FALSE
)
summary(pca_result)
# 19. Create PCA Scree Plot
explained_variance <- pca_result$sdev^2 /
  sum(pca_result$sdev^2)
plot(
  explained_variance[1:15],
  type = "b",
  pch = 19,
  xlab = "Principal Component",
  ylab = "Proportion of Variance Explained",
  main = "PCA Scree Plot"
)
# 20. Determine number of components for 80% variance
cumulative_variance <- cumsum(explained_variance)
which(cumulative_variance >= 0.80)[1]
# 21. Extract the first three principal components
pca_scores <- as.data.frame(
  pca_result$x[, 1:3]
)
pca_scores$activity <- tidy_data$activity
head(pca_scores)
# 22. Visualize the first two principal components
library(ggplot2)
ggplot(pca_scores, aes(x = PC1, y = PC2, color = activity)) +
  geom_point(alpha = 0.6, size = 1.5) +
  labs(
    title = "PCA: First Two Principal Components",
    x = "Principal Component 1",
    y = "Principal Component 2",
    color = "Activity"
  ) +
  theme_minimal()
