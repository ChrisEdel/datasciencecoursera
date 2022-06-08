# setwd("~/coursera")

# loading the data

observations_train <- read.table("UCI HAR Dataset/train/X_train.txt")
labels_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subjects_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

observations_test <- read.table("UCI HAR Dataset/test/X_test.txt")
labels_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subjects_test <- read.table("UCI HAR Dataset/test/subject_test.txt")


# joining sets together (binding by rows)

obersations <- rbind(observations_train, observations_test)
labels <- rbind(labels_train, labels_test)
subjects <- rbind(subjects_train, subjects_test)


# extracting only measurements on the mean and standard deviation

features <- read.table("UCI HAR Dataset/features.txt")

indicesMeanStandardev <- grep("mean\\(\\)|std\\(\\)", features[, 2])
observationsMeanStandarddev <- obersations[, indicesMeanStandardev]
names(observationsMeanStandarddev) <- features[indicesMeanStandardev, 2]


# using descriptive activity names

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activitiesLabels <- activities[labels[, 1], 2]

labels[, 1] <- activityLabel
names(labels) <- "activity"


# labelling the data set with descriptive variable names

names(subjects) <- "subject"

tidyData <- cbind(observationsMeanStandarddev, labels, subjects)

# putting subject and activity first
library(dplyr)
tidyData <- tidyData %>%
  select(subject, activity, everything())

write.table(tidyData, "tidyData.txt") 


# creating data set with the average of each variable for each activity and each subject

numFeatures <- dim(tidyData)[2]
numActivities <- dim(activities)[1]
numSubjects <- length(table(subjects))

tidayDataMean <- as.data.frame(matrix(NA, nrow=numSubjects*numActivities, ncol=numFeatures))
colnames(tidayDataMean) <- colnames(tidyData)

row <- 1

for(i in 1:numSubjects) {
  for(j in 1:numActivities) {
    tidayDataMean[row, 1] <- sort(unique(subjects)[, 1])[i]
    tidayDataMean[row, 2] <- activities[j, 2]
    tidayDataMean[row, 3:numFeatures] <- colMeans(tidyData[i == tidyData$subject & activities[j, 2] == tidyData$activity, 3:numFeatures])
    row <- row + 1
  }
}

write.table(tidayDataMean, "tidayDataMean.txt", row.name=FALSE) 