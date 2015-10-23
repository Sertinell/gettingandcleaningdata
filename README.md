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
