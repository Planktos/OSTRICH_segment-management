library(plyr)
library(data.table)
library(stringr)
library(dplyr)


#list files in Kaggle set
#------------------
setwd("C:/Users/kelly.robinson/Dropbox/Cowen_Sponaugle_share/Outreach/Kaggle/Data set/Kaggle Segments_40K")

files <- list.files(all.files=TRUE, recursive=TRUE, include.dirs=TRUE, pattern = ".jpg", full.names=FALSE)

f <- as.data.frame(files)

colnames(f) <- c("dir")
f$dir <- as.character(f$dir)

f$t0 <- str_split_fixed(f$dir, "/", 2)
f$class <- str_sub(f$t0[,1])
f$segment <- str_sub(f$t0[,2])
f$t0 <- NULL

#create subdirectories
class <- unique(f$class)
for (i in 1:length(class)){
  folders <- paste0("C:/Users/kelly.robinson/Dropbox/Cowen_Sponaugle_share/OSTRICH/ISIIS data/SparseCNN training/Kaggle segments_20K/",class[i])
  dir.create(folders)
}

ddply(.data = f, .variables = "class", function(x){
  
  total_class_segments <- nrow(x)
  no.to.remove <- round(x = total_class_segments*0.333, digits = 0) #set number of segments to remove from each class using 33% reduction threshold
  
  # get df of random number of segments to move
  d <- x[sample(nrow(x), no.to.remove, replace = FALSE, prob = NULL),]
  
  # get list of new directory addresses for segments to be move out of data set
  nd = paste("C:/Users/kelly.robinson/Dropbox/Cowen_Sponaugle_share/OSTRICH/ISIIS data/SparseCNN training/Kaggle segments_20K/",d$class,"/",d$segment,sep="")
  od = paste("C:/Users/kelly.robinson/Dropbox/Cowen_Sponaugle_share/OSTRICH/ISIIS data/SparseCNN training/Kaggle segments_40K/",d$class,"/",d$segment,sep="")
  
  file.rename(from = od, to = nd)

}, .progress = "text")
