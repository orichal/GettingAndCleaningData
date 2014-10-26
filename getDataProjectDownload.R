
getDataProjectDownload <- function() {
    library(RCurl);
    dir<-"UCI HAR Dataset";
    url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
    file<-"getdata_projectfiles_UCI_HAR_Dataset.zip";
    if (!file.exists(dir)) {
        download.file(url, file, method="curl");
        unzip(file);
        unlink(file);
        print(paste0("Downloaded dataset into directory: ", file));
    }
    else {
        print(paste0("Dataset already exists in directory: ", dir));
    }
    return(dir);
}
