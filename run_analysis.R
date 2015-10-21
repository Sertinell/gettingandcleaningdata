#move to data directory
setwd("UCI HAR Dataset/")
#read the names of the columns
features <- read.table("features.txt", header = FALSE)
names(features) <- c("index", "name")
# read labels
activitylabels <- read.table("activity_labels.txt", header = FALSE)
names(labels) <- c("index", "name")

library(data.table)

# Load training features
traindata <- fread("train/X_train.txt")
#load the training labels
trainlabels <- read.table("train/y_train.txt")

trainsubjects <- read.table("train/subject_train.txt")
#change the names according to labels file
setnames(traindata, old = paste0("V", as.character(features$index)), 
         new=as.character(features$name))

#Add the labels columns
traindata[, activity:=trainlabels]
traindata[, subject:=trainsubjects]
# Load test features
testdata <- fread("test/X_test.txt")
#load the testing labels
testlabels <- read.table("test/y_test.txt")
#read test subjects
testsubjects <- read.table("test/subject_test.txt")
#change the names according to labels file
setnames(testdata, old = paste0("V", as.character(features$index)), 
         new=as.character(features$name))
#Add the labels columns
testdata[, activity:=testlabels]
testdata[, subject:=testsubjects]

#concatenate both datasets.
fulldata <- rbind(testdata, traindata)

#rename activity levels
fulldata$activity <- as.factor(fulldata$activity)
levels(fulldata$activity) <- tolower(sub("_", "", activitylabels$V2))

#rename names and drop columns
columnswanted <- names(fulldata)[grep('(mean|std)\\(\\)', x = names(fulldata))]
fulldata <- fulldata[,c(columnswanted, "activity", "subject"), with = FALSE]
names(fulldata) <- tolower(gsub('(-|\"|,|\\(|\\))', "", names(fulldata)))

#group by activity and subject
library(dplyr)
groupeddata <- group_by(fulldata, subject, activity)
tidydata <- groupeddata %>% summarise_each(funs(mean))

write.table(tidydata, row.names = FALSE, col.names = TRUE, file = "tidydata.txt")
