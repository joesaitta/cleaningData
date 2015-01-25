# cleaningData
Project files for Getting and Cleaning Data (getdata-010)

## Running run_analysis.R

The `run_analysis.R contains 5 functions to ingest and clean the data per project requirements.

Running the `getTidyData() function in the same directory as the unzipped UCI HAR Dataset folder will return a cleaned dataframe. This function calls all of the functions necessary to run the dataset through each cleaning step.

The the functions to be called operate as follows:

1. `read_uci_data() will read in relevent data from the UCI HAR Dataset, applies the features data to the observation data headers, merges test and training data into a single dataframe, and returns the merged, properly labeled dataframe.

2. `getMeasuresColumn() takes the merged dataframe as an argument and pulls out the mean and standard deviation columns from the original data set. All columns that contain the mean or std in the description were considered valid and are used for the tidy dataset.

3. `applyActivityNames() takes the mean and std sliced dataframe as an argument and adds a new variable, `activityName, using the `activity_labels.txt file to label the activities appropriately, to the returned dataframe.

4. Finally, `aveData() aggregates the dataframe into the means of each feature, by subject and activity, and returns the final, tidy dataset.