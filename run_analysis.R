#reading features.txt
features <- read.table("./UCI HAR Dataset/features.txt")
#select the rows containing the keywords mean() and std()
selmean <- grep("mean", features[,2])
selstd <- grep("std", features[,2])
#get the name list
feature_names_mean <- features[selmean,2]
feature_names_std <- features[selstd,2]
#generate the list for use in reading select columns from table files. 
selcolmean <- rep(c("NULL"),561)
selcolmean[selmean] <- "numeric"
selcolstd <- rep(c("NULL"),561)
selcolstd[selstd] <- "numeric"
#reading tables
data_train_mean <- read.table("./UCI HAR Dataset/train/X_train.txt",colClasses = selcolmean)
names(data_train_mean) <- feature_names_mean
data_train_std <- read.table("./UCI HAR Dataset/train/X_train.txt",colClasses = selcolstd)
names(data_train_std) <- feature_names_std
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(sub_train) <- c("sub")
label_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
names(label_train) <- c("label")
data_test_mean <- read.table("./UCI HAR Dataset/test/X_test.txt",colClasses = selcolmean)
names(data_test_mean) <- feature_names_mean
data_test_std <- read.table("./UCI HAR Dataset/test/X_test.txt",colClasses = selcolstd)
names(data_test_std) <- feature_names_std
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(sub_test) <- c("sub")
label_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
names(label_test) <- c("label")
#merging data
data_train <- cbind(sub_train,label_train,data_train_mean,data_train_std,rep(c("train"),dim(sub_train)[1]))
names(data_train)[82] <- c("Categories")
data_test <- cbind(sub_test,label_test,data_test_mean,data_test_std,rep(c("test"),dim(sub_test)[1]))
names(data_test)[82] <- c("Categories")
data_total <- rbind(data_train,data_test)
#reading activity label
ac_label <- read.table("./UCI HAR Dataset/activity_labels.txt")
for (i in 1:6){
  data_total$label[data_total$label == i] = as.character(ac_label$V2[i])
}
#group and calculate mean
for(i in 1:6){
  data_mean <- data_total[data_total$label == as.character(ac_label$V2[i]), c(1,3:81)] %>% group_by(sub) %>% summarise_each(funs(mean))
  data_label <- cbind(rep(c(as.character(ac_label$V2[i])),dim(data_mean)[1]),data_mean)
  names(data_label)[1] = c("label")
  if(i == 1) data_tidy = data_label else data_tidy = rbind(data_tidy,data_label)
}
dataMelt <- melt(data_tidy,id=c("label","sub"),measure.vars = names(data_tidy)[3:81])
dataMelt <-rename(dataMelt,features = variable, mean = value)
# write file
write.table(dataMelt,file = "./UCI HAR Dataset/data_tidy.txt",row.names=FALSE)
