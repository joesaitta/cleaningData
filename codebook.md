# Codebook for Cleaning Data Project variables

The dataset returned after processing the UCI HAR Dataset contains a subset of the averaged variables described in the `features.txt` provided in the UCI HAR Dataset and additional variables created during the data cleaning steps.

## New variables (columns 1 & 2)

1. `activityName`: describes the activity being performed by the subject for the observation feature mean
2. `subject`: ID of the subject performing the activity for the observation feature mean

## Feature variables (columns 3 - 88)

Contains all of the features described in the `features.txt` file, selected from the test and training datasets, sub-selected by columns that contain the `mean` or `std` strings.

