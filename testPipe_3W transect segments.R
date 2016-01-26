
library(stringr)

options("digits.secs"=3)

#load 3W_2014 segments
load("d27_filenames.R")

f <- ftype27
f <- as.data.frame(f)

colnames(f) <- c("dir")

#create date & time fields to use to extract transects
f$t <- str_split_fixed(f$dir, "_", 2)
f$dtf <- str_sub(f$t[,1])
f$crop <- str_sub(f$t[,2])
f$t <- NULL
f$dT <- str_sub(f$dtf, 1, 18)
f$yy <- str_sub(f$dT, 1, 4)
f$mm <- str_sub(f$dT, 5, 6)
f$dd <- str_sub(f$dT, 7, 8)
f$hh <- str_sub(f$dT, 9, 10)
f$min <- str_sub(f$dT, 11, 12)
f$sec <- str_sub(f$dT, 13, 18)
f$time <- str_c(f$hh, f$min, f$sec, sep=":")

#create dateTime field and adjust time-stamp per the location of frame in the stack
  # 430 frames per stack
  # mean 24.46 seconds between each stack (averaged over ~600 stacks)
  # if 430 frames then 0.05688609 sec per frame
  f$dateTime <- as.POSIXct(str_sub(f$dir, 1, 14), format="%Y%m%d%H%M%OS", tz="America/New_York") + as.numeric(str_sub(f$dir, 16, 18))/1000
  f$frame <- as.numeric(str_sub(f$dir, 20, 23))
  f$frame <- f$frame - 1 #the first frame's time-stamp should be the same as the time-stamp for the start of the stack so multiply by 0 for 1st frame
  f$dateTime <- f$dateTime + f$frame*0.05688609
  
  
#3W-undulation
  #start time
  und_start <- subset(f, time > "06:42")
  #end time of undulation transect
  und_end <- subset(f, time < "07:44")
  
  #create directory
  dir.create("E:/3W_und")
  
  #copy files over to a specific "undulation tow folder"
  od <- paste0("F:/OST2014_d27_bigcamera/d27/",f$dT,"/",f$dtf,"/seg/",f$dir)
  nd <- paste0("E:/3W_und/",f$dir)
  file.copy(from = od, to = nd)
  
  
#3W-mid
  #start time
  m_start <- subset(f, time > "07:57")
  #end time of undulation transect
  m_end <- subset(f, time < "09:13")
  
  #create directory
  dir.create("E:/3W_mid")
  
  #copy files over to a specific "undulation tow folder"
  od <- paste0("F:/OST2014_d27_bigcamera/d27/",f$dT,"/",f$dtf,"/seg/",f$dir)
  nd <- paste0("E:/3W_mid/",f$dir)
  file.copy(from = od, to = nd)
  

#3W-deep
  #start time
  d_start <- subset(f, time > "13:05")
  #end time of undulation transect
  d_end <- subset(f, time < "13:57")
  
  #create directory
  dir.create("E:/3W_deep/")
  
  #copy files over to a specific "undulation tow folder"
  od <- paste0("F:/OST2014_d27_bigcamera/d27/",f$dT,"/",f$dtf,"/seg/",f$dir)
  nd <- paste0("E:/3W_deep",f$dir)
  file.copy(from = od, to = nd)  
  

#3W-shallow
  #start time
  s_start <- subset(f, time > "16:40")
  #end time of undulation transect
  s_end <- subset(f, time < "17:39")

  #create directory
  dir.create("E:/3W_shallow")
  
  #copy files over to a specific "undulation tow folder"
  od <- paste0("F:/OST2014_d27_bigcamera/d27/",f$dT,"/",f$dtf,"/seg/",f$dir)
  nd <- paste0("E:/3W_shallow/",f$dir)
  file.copy(from = od, to = nd)
  
  