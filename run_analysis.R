source("getDataProjectDownload.R");

run_analysis <- function() {
    projDir <- getDataProjectDownload();
    origDir<-getwd();
    setwd(projDir);
    
    features<-read.table("features.txt");
    names(features)<-c("columnNumber", "feature");
    features$featureName<-as.character(features$feature); # turn levels to srings
    # requiredFeatures is a data frame with only mean and standard deviation measurments
    patMeanStd <- "(mean|std)\\(";
    requiredFeatures <- features[grep(patMeanStd, features$featureName), c("columnNumber", "featureName")];
    requiredFeatures$columnName <- paste("V", requiredFeatures$columnNumber, sep="");
    features$colClasss <- sapply((regexpr(patMeanStd, features$featureName) > 0), function (cond) {if (cond) {"numeric"} else {"NULL"}});
    
    # subject will contain a merge of subject (user) of train and test
    # subject are numbers, so we add the maximum train nummber to the test number, in order to have unique numbers
    subject_train <- read.table("train/subject_train.txt");
    subject_test <- read.table("test/subject_test.txt");
    subject_test$V1 <- subject_test$V1 + c(max(subject_train$V1)); # Create unique subjects across train and test
    subject <- rbind(subject_train, subject_test);
    names(subject) <- c("Subject");
    
    # activity will contain meaningful factors of the 6 types of activities, merged from train and test
    activity_labels <- read.table("activity_labels.txt");
    activity_train <- read.table("train/y_train.txt");
    activity_test <- read.table("test/y_test.txt");
    activity <- rbind(activity_train, activity_test);
    activity$V1 <- activity_labels[activity$V1, "V2"];
    names(activity) <- "Activity";
    
    # X will contain:
    #   Columns - only the mean an standard deviation features
    #   Column names - the mean an standard deviation features, e.g. "tBodyAcc-mean()-X"
    #   rows - a merge of train and test sets
    # Due to the large size of X, Cutting columns and merging are done right at the file read,
    #   in order to minimize the use of memory
    X <- rbind(read.table("train/X_train.txt", colClasses=features$colClasss), read.table("test/X_test.txt", colClasses=features$colClasss));
    names(X) <- requiredFeatures$featureName;
    
    # tidyDataSet will contain a column merge of subject, activity and X
    tidyDataSet <- cbind(subject, activity, X);
    
    # Finally, create a CSV file of tidyDataSet and return the file name
    setwd(origDir);
    tidyDataSet_csv <- "tidyDataSet.csv";
    tidyDataSet_txt <- "tidyDataSet.txt";
    #write.csv(tidyDataSet, tidyDataSet_csv);
    write.table(tidyDataSet, tidyDataSet_txt, row.names = FALSE);
    #print(paste("Created ", tidyDataSet_csv));
    print(paste("Created ", tidyDataSet_txt));
    
    tidyDataSet_txt;
}