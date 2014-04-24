#Creating the first tidy dataset
#current directory
getwd()

#setting working directory
setwd("C:/Users/Akki/Desktop/Coursera/Getting and Cleaning Data/Assignment")

#downloading data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="data.zip")
dir()

#extracting data
unzip("data.zip")
dir()



#loading the activity_labels data
activity_labels<-read.table("C:/Users/Akki/Desktop/Coursera/Getting and Cleaning Data/Assignment/UCI HAR Dataset/activity_labels.txt")
head(activity_labels)
tail(activity_labels)
nrow(activity_labels)
ncol(activity_labels)
colnames(activity_labels)<-c("Label","Activity")
#View(activity_labels)

#loading the features data
features<-read.table("C:/Users/Akki/Desktop/Coursera/Getting and Cleaning Data/Assignment/UCI HAR Dataset/features.txt")
head(features)
tail(features)
nrow(features)
ncol(features)
colnames(features)<-c("Number","Feature")
#View(features)


#loading test data
x_test<-read.table("C:/Users/Akki/Desktop/Coursera/Getting and Cleaning Data/Assignment/UCI HAR Dataset/test/X_test.txt")
head(x_test)
tail(x_test)
nrow(x_test)
ncol(x_test)
colnames(x_test)<-features$Feature
#View(x_test)

y_test<-read.table("C:/Users/Akki/Desktop/Coursera/Getting and Cleaning Data/Assignment/UCI HAR Dataset/test/y_test.txt")
head(y_test)
tail(y_test)
nrow(y_test)
ncol(y_test)
colnames(y_test)<-"Label"
y_test_1<-(merge(y_test,activity_labels))

subject_test<-read.table("C:/Users/Akki/Desktop/Coursera/Getting and Cleaning Data/Assignment/UCI HAR Dataset/test/subject_test.txt")
head(subject_test)
tail(subject_test)
nrow(subject_test)
ncol(subject_test)
colnames(subject_test)<-"Subject"

#loading train data
x_train<-read.table("C:/Users/Akki/Desktop/Coursera/Getting and Cleaning Data/Assignment/UCI HAR Dataset/train/X_train.txt")
head(x_train)
tail(x_train)
nrow(x_train)
ncol(x_train)
colnames(x_train)<-features$Feature
#View(x_train)

y_train<-read.table("C:/Users/Akki/Desktop/Coursera/Getting and Cleaning Data/Assignment/UCI HAR Dataset/train/y_train.txt")
head(y_train)
tail(y_train)
nrow(y_train)
ncol(y_train)
colnames(y_train)<-"Label"
y_train_1<-(merge(y_train,activity_labels))

subject_train<-read.table("C:/Users/Akki/Desktop/Coursera/Getting and Cleaning Data/Assignment/UCI HAR Dataset/train/subject_train.txt")
head(subject_train)
tail(subject_train)
nrow(subject_train)
ncol(subject_train)
colnames(subject_train)<-"Subject"


##merging test data to subject and activity
test<-cbind(subject_test,y_test_1,x_test)
test<-test[,-2]
View(test)


##merging train data to subject and activity
train<-cbind(subject_train,y_train_1,x_train)
train<-train[,-2]
#View(train)


#merging test and train data
expdata<-rbind(test,train)
#View(expdata)

##retaining only the variables related to mean or standard deviation
index<- c(1,2,grep("mean()|std()",colnames(expdata)))
expdata_1<-expdata[,c(index)]
index2<-c(grep("Freq",colnames(expdata_1)))
expdata_2<-expdata_1[,-c(index2)]
#View(expdata_2)

##cleaning variable names
names<-colnames(expdata_2)
names2<-gsub("^[t]","Time Domain ",names)
names3<-gsub("^[f]","Frequency Domain ",names2)
names4<-gsub("Acc"," Acceleration",names3)
names5<-gsub("Gyro"," Angular Velocity",names4)
names6<-gsub("Mag"," Magnitude",names5)
names7<-gsub("\\()","",names6)
names8<-gsub("std","Standard Deviation",names7)
names9<-gsub("BodyBody","Body",names8)
names10<-gsub("AccelerationJerk","Jerk Acceleration",names9)
names11<-gsub("Angular VelocityJerk","Jerk Angular Velocity",names10)
##index3<-grep("Jerk",names9)
#View(names11)


#creating the tidy dataset
tidydata<-(expdata_2)
colnames(tidydata)<-names11
#View(tidydata)

##first tidy dataset created

#creating an independent aggregated tidy dataset
tidy2<-aggregate(expdata[,c(3:563)],expdata[,c(1,2)],mean)
#View(tidy2)


#cleaning variable names
name<-colnames(tidy2)
name2<-gsub("^[t]","Time Domain ",name)
name3<-gsub("^[f]","Frequency Domain ",name2)
name4<-gsub("Acc"," Acceleration",name3)
name5<-gsub("Gyro"," Angular Velocity",name4)
name6<-gsub("Mag"," Magnitude",name5)
name7<-gsub("\\()","",name6)
name8<-gsub("BodyBody","Body",name7)
name9<-gsub("AccelerationJerk","Jerk Acceleration",name8)
name10<-gsub("Angular VelocityJerk","Jerk Angular Velocity",name9)
name11<-gsub("angle\\(t","angle\\(Time Domain ",name10)
name12<-c("Subject","Activity",gsub("^","Average of ",name11[3:563]))
#View(name11)



#creating the second tidy dataset
tidydata2<-(tidy2)
colnames(tidydata2)<-name12
#View(tidydata2)


#exporting the datasets
write.table(tidydata, "Tidy Data.txt", sep="\t")
write.table(tidydata2, "Tidy Data 2.txt", sep="\t")
