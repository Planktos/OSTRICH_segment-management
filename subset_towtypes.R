
library("plyr")
library("stringr")

options("digits.secs"=3)

# Station 2C
# -----------------------------

files <- list.files(path = "E:/OST2014_d11_bigcamera/d11/classifiedSegments", recursive = T, full.names = T, include.dirs = T, pattern = ".jpg")

f <- as.data.frame(files)

colnames(f) <- c("dir")

f$dir <- as.character(f$dir)
f$t0 <- str_split_fixed(f$dir, "./", 2)
f$dir <- str_sub(f$t0[,2])
f$t1 <- str_split_fixed(f$dir, "/", 2)
f$class <- str_sub(f$t1[,1])

f$t2 <- str_sub(f$t1[,2])
f$t3 <- str_split_fixed(f$t2, "_", 2)
f$dtf <- str_sub(f$t3[,1])
f$crop <- str_sub(f$t3[,2])

f$t0 <- NULL
f$t1 <- NULL
f$t2 <- NULL
f$t3 <- NULL

f$dT <- str_sub(f$dtf, 1, 18)

f$yy <- str_sub(f$dT, 1, 4)
f$mm <- str_sub(f$dT, 5, 6)
f$dd <- str_sub(f$dT, 7, 8)
f$hh <- str_sub(f$dT, 9, 10)
f$min <- str_sub(f$dT, 11, 12)
f$sec <- str_sub(f$dT, 13, 18)

f$date <- str_c(f$yy, f$mm, f$dd,  sep="-")
f$time <- str_c(f$hh, f$min, f$sec, sep=":")
f$dateTime <- str_c(f$date, f$time, sep=" ")
f$dateTime <- as.POSIXct(strptime(f$dateTime, format="%Y-%m-%d %H:%M:%OS", tz="America/New_York"))

#start time of undulation transect
und_s <- subset(f, time > "08:36")
#end time of undulation transect
und <- subset(und_s, time < "10:16")

# clean up
und$dT <- NULL
und$dtf <- NULL
und$crop <- NULL
und$yy <- NULL
und$mm <- NULL
und$dd <- NULL
und$hh <- NULL
und$min <- NULL
und$sec <- NULL

#create directory and subdirectories
class <- unique(und$class)
dir.create("C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/2c_undulation")

for (i in 1:length(class)){
  folders <- paste0("C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/2c_undulation/",class[i])
  dir.create(folders)
  }
  
#copy files over to a specific "undulation tow folder"
od <- paste0("E:/OST2014_d11_bigcamera/d11/classifiedSegments/",und$dir)
nd <- paste0("C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/2c_undulation/",und$dir)
file.copy(from = od, to = nd)

#make a list of the original undulation transect segment classifications
write.table(und, file = "C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/2c_undulation/2C_d11_undulation_ccs_class.txt", sep = "," , row.names = FALSE, col.names = TRUE)


##post copy file check to make sure files were copied NOT moved from original classifed directory
##------
  pfiles <- list.files("C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/classifiedSegments/", full.names=TRUE, recursive = TRUE, pattern = ".jpg")
  pcf <- as.data.frame(files) #pcf stands for post-copy files
  
  und_files <- list.files(full.names = TRUE, recursive = TRUE, pattern = ".jpg")
  und_f <- as.data.frame(und_files)
  
  
  colnames(pcf) <- c("dir")
  pcf$dir <- as.character(pcf$dir)
  pcf$folder.pcf <- "classifiedSegments"
  pcf$t1 <- str_split_fixed(pcf$dir, "//", 2)
  pcf$direct <- str_sub(pcf$t1[,2])
  
  colnames(und_f) <- c("direct")
  und_f$dir <- as.character(und_f$dir)
  und_f$folder.und <- "1W_undulation"
  und_f$t1 <- str_split_fixed(und_f$dir, "./", 2)
  und_f$direct <- str_sub(und_f$t1[,2])
  
  c <- join(pcf, und_f, by="direct")
  
  summary(c)
  
  cs <- subset(c, folder == "1W_undulation")

# Station 3W
# -----------------------------
files <- list.files(path = "E:/OST2014_d27_bigcamera/d27/ClassifiedSegments", recursive = T, full.names = T, include.dirs = T, pattern = ".jpg")
f <- as.data.frame(files, stringsAsFactors = FALSE)

colnames(f) <- c("dir")

f$dir <- as.character(f$dir)
f$t0 <- str_split_fixed(f$dir, "/", 6)
f$dir <- str_sub(f$t0[,6])
f$class <- str_sub(f$t0[,5])

f$t2 <- str_sub(f$t0[,6])
f$t3 <- str_split_fixed(f$t2, "_", 2)
f$dtf <- str_sub(f$t3[,1])
f$crop <- str_sub(f$t3[,2])

f$t0 <- NULL
f$t2 <- NULL
f$t3 <- NULL

f$dT <- str_sub(f$dtf, 1, 18)

f$yy <- str_sub(f$dT, 1, 4)
f$mm <- str_sub(f$dT, 5, 6)
f$dd <- str_sub(f$dT, 7, 8)
f$hh <- str_sub(f$dT, 9, 10)
f$min <- str_sub(f$dT, 11, 12)
f$sec <- str_sub(f$dT, 13, 18)

f$date <- str_c(f$yy, f$mm, f$dd,  sep="-")
f$time <- str_c(f$hh, f$min, f$sec, sep=":")
f$dateTime <- str_c(f$date, f$time, sep=" ")
f$dateTime <- as.POSIXct(strptime(f$dateTime, format="%Y-%m-%d %H:%M:%OS", tz="America/New_York"))

#start time of undulation transect
und_s <- subset(f, time > "06:42")
#end time of undulation transect
und <- subset(und_s, time < "07:44")

# clean up
und$dT <- NULL
und$dtf <- NULL
und$crop <- NULL
und$yy <- NULL
und$mm <- NULL
und$dd <- NULL
und$hh <- NULL
und$min <- NULL
und$sec <- NULL

#create directory and subdirectories
class <- unique(und$class)
dir.create("C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/3W_undulation")

for (i in 1:length(class)){
  folders <- paste0("C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/3W_undulation/",class[i])
  dir.create(folders)
}

#copy files over to a specific "undulation tow folder"
od <- paste0("E:/OST2014_d27_bigcamera/d27/ClassifiedSegments/",und$class,"/",und$dir)
nd <- paste0("C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/3W_undulation/",und$class,"/",und$dir)
file.copy(from = od, to = nd)

#make a list of the original undulation transect segment classifications
write.table(und, file = "C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/3W_undulation/3W_d27_undulation_ccs_class.txt", sep = "," , row.names = FALSE, col.names = TRUE)
# Station 3C
# ----------
files <- list.files(path = "E:/OST2014_d27_bigcamera/d27/ClassifiedSegments", recursive = T, full.names = T, include.dirs = T, pattern = ".jpg")
f <- as.data.frame(files, stringsAsFactors = FALSE)

colnames(f) <- c("dir")

f$dir <- as.character(f$dir)
f$t0 <- str_split_fixed(f$dir, "/", 6)
f$dir <- str_sub(f$t0[,6])
f$class <- str_sub(f$t0[,5])

f$t2 <- str_sub(f$t0[,6])
f$t3 <- str_split_fixed(f$t2, "_", 2)
f$dtf <- str_sub(f$t3[,1])
f$crop <- str_sub(f$t3[,2])

f$t0 <- NULL
f$t2 <- NULL
f$t3 <- NULL

f$dT <- str_sub(f$dtf, 1, 18)

f$yy <- str_sub(f$dT, 1, 4)
f$mm <- str_sub(f$dT, 5, 6)
f$dd <- str_sub(f$dT, 7, 8)
f$hh <- str_sub(f$dT, 9, 10)
f$min <- str_sub(f$dT, 11, 12)
f$sec <- str_sub(f$dT, 13, 18)

f$date <- str_c(f$yy, f$mm, f$dd,  sep="-")
f$time <- str_c(f$hh, f$min, f$sec, sep=":")
f$dateTime <- str_c(f$date, f$time, sep=" ")
f$dateTime <- as.POSIXct(strptime(f$dateTime, format="%Y-%m-%d %H:%M:%OS", tz="America/New_York"))

#start time of undulation transect
und_s <- subset(f, time > "06:42")
#end time of undulation transect
und <- subset(und_s, time < "07:44")

# clean up
und$dT <- NULL
und$dtf <- NULL
und$crop <- NULL
und$yy <- NULL
und$mm <- NULL
und$dd <- NULL
und$hh <- NULL
und$min <- NULL
und$sec <- NULL

#create directory and subdirectories
class <- unique(und$class)
dir.create("C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/3W_undulation")

for (i in 1:length(class)){
  folders <- paste0("C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/3W_undulation/",class[i])
  dir.create(folders)
}

#copy files over to a specific "undulation tow folder"
od <- paste0("E:/OST2014_d27_bigcamera/d27/ClassifiedSegments/",und$class,"/",und$dir)
nd <- paste0("C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/3W_undulation/",und$class,"/",und$dir)
file.copy(from = od, to = nd)

#make a list of the original undulation transect segment classifications
write.table(und, file = "C:/Users/kelly.robinson/Documents/OSTRICH 2014_ISIIS segments_REU/3W_undulation/3W_d27_undulation_ccs_class.txt", sep = "," , row.names = FALSE, col.names = TRUE)




