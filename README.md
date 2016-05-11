# Reading in and cleaning fitbit data 

The first part of the script sets the working directory and reads all the necessary tables using the  ```read.table()``` function. \n

Following the test and train data is combined using the ```cbind()``` function. \n

The mean and standard deviation data is extracted from the combined data set using the ```grep()``` function. \n
Activity labels are then taken from the table and converted to human readable form. Column names are created in a similar manner\n

Finally a table for the average of the mean and standard deviation data is constructed using the ```melt()``` and ```dcast()``` functions. 
