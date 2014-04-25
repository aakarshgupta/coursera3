=========
Getting and Cleaning Data
=========

run_analysis.R

Code Flow:
1. Checking the current work directory
2. Setting the working directory to the desired directory "~/Assignment"
3. Next the .zip data file is downloaded into the work directory
4. Command Unzip is used to extract the contents of the downloaded .zip data


Assumption#: The downloaded data has inertial raw experimental data.
      This data is already processed to come up with the data know 
      as train and train data for the assignment requirement.
      
5. Next the data activity labels is loaded into R, this data has a label# and its corresponding activity name mapping.
    activity_labels : 6*2
6. Next the features data is loaded , this essentially acts as the variable names for the data under consideration.
    features : 561*2  (acts a variable names)

7. Now the x_test,y_test,subject_test data is loaded.
    x_test : 2947*561 (acts as metric measures) this is further merged with the features data that acts as colnames
    y_test : 2947*1 (acts as activity label) this is further merged with activity labels to create 2947*2 y_test_1 dataset
    subject_test : 2947*1 (acts as the identity of the experiment subject)
This data is merged (cbind) to create a 2947*564 data set then the activity label# are stripped off and activity names are retained.
    subject_test + y_test_1 + x_test = test (2947*563)


8. Now the x_train,y_train,subject_train data is loaded.
    x_train : 7352*561 (acts as metric measures) this is further merged with the features data that acts as colnames
    y_train : 7352*1 (acts as activity label) this is further merged with activity labels to create 2947*2 y_train_1 dataset
    subject_train : 7352*1 (acts as the identity of the experiment subject)
This data is merged (cbind) to create a 7352*564 data set then the activity label# are stripped off and activity names are retained.
    subject_train + y_train_1 + x_train = train (7352*563)

9.  the test and train data is then rbind to produce the raw expdata (10,299 * 563)

10. Next we proceed with creating the first tidy data set.
11. using grep() the data variables with only mean , std and meanfreq are retained : expdata_1 (10,299 * 81)
12. As per requirement we need only mean and standard deviation, so freq variables are removed : expdata_2 (10,299 *68)
13. finally the variable names are updated using the gsub()  function and first tidy dataset is created
     tidydata : 10,22 *68

Now we proceed with the second tidy dataset as mentioed in step 5 of the problem instructions

14. The dataset expdata is used and all the 561 variables are aggregated to obtain their average at subject-Activity level : tidy2 (40* 563)
15. now using the grep() function as earlier the variable names are updated to make them more intutive.
16. finally , we obtain our second tidy dataset
    tidydata2 : 40*563

17. Next the two datasets are exported as text files using the write.table command.

    tidydata --> Tidy Data.txt
    tidydata2--> Tidy Data 2.txt
    
    
Note : the R script submitted with the assignment is commented at regular intervals to make the code more intutive.






