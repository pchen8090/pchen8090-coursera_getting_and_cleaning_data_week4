library(dplyr)


#construct data table
genDf <- function(pth,dtType) {
  f <- read.delim("UCI HAR Dataset/features.txt",header=FALSE)
  a_label <- read.delim("UCI HAR Dataset/activity_labels.txt",sep="",header=FALSE)
  x <- read.delim(file.path(pth,sprintf("X_%s.txt",dtType)),sep="",header=FALSE)
  y <- read.delim(file.path(pth,sprintf("y_%s.txt",dtType)),header=FALSE)
  # label dataset
  subject <- read.delim(file.path(pth,sprintf("subject_%s.txt",dtType)),header=FALSE)
  
  colnames(x)<-f[,1]
  # bind activity
  act <- lapply(y,function(v1) { a_label[v1,2] })
  x<-cbind(x,activity=unlist(act,use.names=FALSE))
  x<-cbind(x,subject=unlist(subject,use.names=FALSE))
  x
}


# load libraries
tb1 <- genDf("./UCI HAR Dataset/test/","test")
tb2 <- genDf("./UCI HAR Dataset/train/","train")
tb3 <- rbind(tb1,tb2)
# select only mean,std,activity
tb4 <- select(tb3,sort(c(grep("mean\\(\\)",names(tb3)),grep("std\\(\\)",names(tb3)))),562,563)
# clear memory
rm(tb1)
rm(tb2)
rm(tb3)
# remove # from column names
colnames(tb4) <- gsub("^[0-9]+ +","",names(tb4))
# summary of table by activity and mean values
summary <- group_by(tb4,activity,subject) %>% summarize_all(mean)

write.csv(summary,"summary.csv")
txt <- write.table(summary,file="summary.txt",row.names = FALSE)

