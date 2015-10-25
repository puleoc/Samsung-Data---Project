Introduction

The script run_analysis.R performs the 5 steps described in the course project.

The intitial lines are used for downloading and unzipping the data; please remove these if you've already put the data in your directory (and remember to change directories to the one with the data)

In the file rbind() is used to merge the trainding and test data sets.

Only those columns containing avg and std data are selected, and extracted from the original data sets.

In order to create a tidy dataset the names of the columns/variable are changed to be descriptive(activity names are taken from activity_labels.txt)

A final new dataset is generated containing all the averages for each subject testing (for each activity) - since the data was from 30 subjects performing 6 different activities this created 180 rows.

The output data file (from running the script) is called Samsung Average Data

Variable Names used: XTrain, YTrain, SubjectTrain, XTest, YTest, SubjectTest (contain original data)

Feattures: contains the correct names for the x data set (given to final data columsn)

MeanSTD: Vector used to select the columns with mean/std values

Activities: contains the correct names for y data set (given to rows)

ddply() from the plyr package is used to apply colMeans().
