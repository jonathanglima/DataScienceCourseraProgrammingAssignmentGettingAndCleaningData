# DataScienceCourseraProgrammingAssignmentGettingAndCleaningData
Attention: this script only runs if the directory "UCI HAR Dataset" is renamed to "dataset". This was made to make the import easier on the script.

This script reads the training and testing datasets by Coursera, binds them with their respective activity and subject datasets and with each other's result.

After that it uses the features dataset to get the columns that are really needed (mean and std variation) and apply it as the column names for the bindedData.

We also use the activity dataset to label all results on activity data using the factor function.

To finish, we aggregate by activity and subject applying the mean function to result in a tidy dataset that is writen on file.

Code book describing variables:

train: training dataset, merged with training activities and it's subjects
test: testing dataset, merged with testing activities and it's subjects
bindedData: the dataset with merged training and testing data
activityLabels: dataset with the activity Id's and corresponding labels, used to replace the Ids on the bindedData
features: features dataset, used to name the columns on the bindedData dataset
tidyData: aggregated data by activity and subject, from bindedData dataset, used to write the tidy.txt file
