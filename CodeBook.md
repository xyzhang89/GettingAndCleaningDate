
##DATA DICTIONARY - Tidy Data with Mean for Human Activity Recognition Using Smartphones Dataset

###label 
    activity names.
      *"WALKING"
      *"WALKING_UPSTAIRS"
      *"WALKING_DOWNSTAIRS"
      *"SITTING"
      *"STANDING"
      *"LAYING" 
###sub
    ID of subject.
      *1..30  .ID of the 30 volunteers, range from 1 to 30
###features
    measurements on the mean and standard deviation for each measurement.
      *"tBodyAcc-mean()-X",.. .79 features selected among the total 561 features 
###mean
    average of each normalized feature for each activity and each subject.
      *-1.0...1.0 .Normalized mean bounded within [-1,1]
