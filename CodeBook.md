---
title: "CourseProject"
author: "Sertinell"
date: "23 October 2015"
output: html_document
---

##Coursera Getting & Cleaning data course project
This dataset is the answer to the final course project of this course: https://class.coursera.org/getdata-033

The dataset is contained in the file "tidydata.txt".

The dataset summarize the average values of means and standard deviations found in
the original dataset.

We have loaded the files "train/X\_train.txt", "train/y\_train.txt", 
"train/subject\_train.txt". Those files have the same number of columns, so they 
can be _cbind_ed to obtain the complete _original data set_. We have also used 
the contents of the file "features.txt" to name the columns of the original 
dataset, as described in the original "README.txt". This actions have been repeated 
over the test dataset. Then, we can _rbind_ test and train datasets to obtain a
full dataset.

On the full dataset, we have labeled the activity as factor by
```r
fulldata$activity <- as.factor(fulldata$activity)
levels(fulldata$activity) <- tolower(sub("_", "", activitylabels$V2))
```

We have extracted the desired columns using _regexps_ by:

```r
columnswanted <- names(fulldata)[grep('(mean|std)\\(\\)', x = names(fulldata))]
fulldata <- fulldata[,c(columnswanted, "activity", "subject"), with = FALSE]
```

We have also cleaned the column names by:

```r
names(fulldata) <- tolower(gsub('(-|\"|,|\\(|\\))', "", names(fulldata)))
```

And finally we have summarized our dataset by _subject_ and _activity_ by:

```r
groupeddata <- group_by(fulldata, subject, activity)
tidydata <- groupeddata %>% summarise_each(funs(mean))
```

The file "columns.txt" contains the correspondence between the original columns
names, extracted from the original data set, and the columnames in our dataset.

Colums "subject" and "activity" has been extracted from files "y\_\$set.txt" and "subject\_\$set.txt" from each dataset:

```
subject: The voluntary of each experiment. From 0 to 30.
activity: Activity label of each row. Has 6 levels.
```

The others columns contains:

```
tbodyaccmeanx: average value of original column tBodyAcc-mean()-X
tbodyaccmeany: average value of original column tBodyAcc-mean()-Y
tbodyaccmeanz: average value of original column tBodyAcc-mean()-Z
tbodyaccstdx: average value of original column tBodyAcc-std()-X
tbodyaccstdy: average value of original column tBodyAcc-std()-Y
tbodyaccstdz: average value of original column tBodyAcc-std()-Z
tgravityaccmeanx: average value of original column tGravityAcc-mean()-X
tgravityaccmeany: average value of original column tGravityAcc-mean()-Y
tgravityaccmeanz: average value of original column tGravityAcc-mean()-Z
tgravityaccstdx: average value of original column tGravityAcc-std()-X
tgravityaccstdy: average value of original column tGravityAcc-std()-Y
tgravityaccstdz: average value of original column tGravityAcc-std()-Z
tbodyaccjerkmeanx: average value of original column tBodyAccJerk-mean()-X
tbodyaccjerkmeany: average value of original column tBodyAccJerk-mean()-Y
tbodyaccjerkmeanz: average value of original column tBodyAccJerk-mean()-Z
tbodyaccjerkstdx: average value of original column tBodyAccJerk-std()-X
tbodyaccjerkstdy: average value of original column tBodyAccJerk-std()-Y
tbodyaccjerkstdz: average value of original column tBodyAccJerk-std()-Z
tbodygyromeanx: average value of original column tBodyGyro-mean()-X
tbodygyromeany: average value of original column tBodyGyro-mean()-Y
tbodygyromeanz: average value of original column tBodyGyro-mean()-Z
tbodygyrostdx: average value of original column tBodyGyro-std()-X
tbodygyrostdy: average value of original column tBodyGyro-std()-Y
tbodygyrostdz: average value of original column tBodyGyro-std()-Z
tbodygyrojerkmeanx: average value of original column tBodyGyroJerk-mean()-X
tbodygyrojerkmeany: average value of original column tBodyGyroJerk-mean()-Y
tbodygyrojerkmeanz: average value of original column tBodyGyroJerk-mean()-Z
tbodygyrojerkstdx: average value of original column tBodyGyroJerk-std()-X
tbodygyrojerkstdy: average value of original column tBodyGyroJerk-std()-Y
tbodygyrojerkstdz: average value of original column tBodyGyroJerk-std()-Z
tbodyaccmagmean: average value of original column tBodyAccMag-mean()
tbodyaccmagstd: average value of original column tBodyAccMag-std()
tgravityaccmagmean: average value of original column tGravityAccMag-mean()
tgravityaccmagstd: average value of original column tGravityAccMag-std()
tbodyaccjerkmagmean: average value of original column tBodyAccJerkMag-mean()
tbodyaccjerkmagstd: average value of original column tBodyAccJerkMag-std()
tbodygyromagmean: average value of original column tBodyGyroMag-mean()
tbodygyromagstd: average value of original column tBodyGyroMag-std()
tbodygyrojerkmagmean: average value of original column tBodyGyroJerkMag-mean()
tbodygyrojerkmagstd: average value of original column tBodyGyroJerkMag-std()
fbodyaccmeanx: average value of original column fBodyAcc-mean()-X
fbodyaccmeany: average value of original column fBodyAcc-mean()-Y
fbodyaccmeanz: average value of original column fBodyAcc-mean()-Z
fbodyaccstdx: average value of original column fBodyAcc-std()-X
fbodyaccstdy: average value of original column fBodyAcc-std()-Y
fbodyaccstdz: average value of original column fBodyAcc-std()-Z
fbodyaccjerkmeanx: average value of original column fBodyAccJerk-mean()-X
fbodyaccjerkmeany: average value of original column fBodyAccJerk-mean()-Y
fbodyaccjerkmeanz: average value of original column fBodyAccJerk-mean()-Z
fbodyaccjerkstdx: average value of original column fBodyAccJerk-std()-X
fbodyaccjerkstdy: average value of original column fBodyAccJerk-std()-Y
fbodyaccjerkstdz: average value of original column fBodyAccJerk-std()-Z
fbodygyromeanx: average value of original column fBodyGyro-mean()-X
fbodygyromeany: average value of original column fBodyGyro-mean()-Y
fbodygyromeanz: average value of original column fBodyGyro-mean()-Z
fbodygyrostdx: average value of original column fBodyGyro-std()-X
fbodygyrostdy: average value of original column fBodyGyro-std()-Y
fbodygyrostdz: average value of original column fBodyGyro-std()-Z
fbodyaccmagmean: average value of original column fBodyAccMag-mean()
fbodyaccmagstd: average value of original column fBodyAccMag-std()
fbodybodyaccjerkmagmean: average value of original column fBodyBodyAccJerkMag-mean()
fbodybodyaccjerkmagstd: average value of original column fBodyBodyAccJerkMag-std()
fbodybodygyromagmean: average value of original column fBodyBodyGyroMag-mean()
fbodybodygyromagstd: average value of original column fBodyBodyGyroMag-std()
fbodybodygyrojerkmagmean: average value of original column fBodyBodyGyroJerkMag-mean()
fbodybodygyrojerkmagstd: average value of original column fBodyBodyGyroJerkMag-std()
```
