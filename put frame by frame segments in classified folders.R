library("plyr")
library("stringr")
library("dplyr")
library("data.table")

#list image (.jpg) files in frame folders
files_jpg <- list.files(recursive = TRUE, pattern = ".jpg")

#list CCS computer classifications .txt files
files_txt <- list.files(recursive = TRUE, pattern = ".txt")

#get classifications for each image from classification text files
classes <- adply(.data = files_txt, 1, function(file){
  
  # read classification text file
  t <- read.table(file, header=F, sep="/", fileEncoding="UTF-8", skipNul = TRUE, stringsAsFactors = FALSE)
  t$V1 <- NULL
  t$V2 <- NULL
  t$V3 <- NULL
  t$V4 <- NULL
  t$V8<- NULL
  
  #name the fields
  colnames(t) <- c("drive", "dateTime_stamp", "dateTime_frame", "segment_name")
  
  #add the classification using the name of the text file
  temp <- basename(file)
  t$class <- gsub('\\..*$','', temp)
  t$segment_name <- as.character(t$segment_name)
  
  return(t)
  head
}, .progress="text")

classes <- classes[,-1]

#create a data frame with segment file names
segments <- adply(.data = files_jpg, 1, function(x){
  i <- as.data.frame(files_jpg, stringsAsFactors = FALSE)
  i$temp <- str_split_fixed(i$files_jpg, pattern = "/", 3)
  i$segment_name  <- str_sub(i$temp[,3])
  #clean up
  i$temp <- NULL

  return(i)
  head
}, .progress="text")

segments <- segments[,-1]

c <- merge(x = segments, y = classes, by = "segment_name", all.x = TRUE)

class <- unique(c$class)
dir.create("//nemo.hmsc.oregonstate.edu/PLANKTON LAB/OgdenFungREU/class_assoc_test/ClassifiedSegments/")

for (i in 1:length(class)){
  folders <- paste0("//nemo.hmsc.oregonstate.edu/PLANKTON LAB/OgdenFungREU/class_assoc_test/ClassifiedSegments/",class[i])
  dir.create(folders)
}

#copy images files to "Classifiedsegments" folder
od <- paste0("//nemo.hmsc.oregonstate.edu/PLANKTON LAB/OgdenFungREU/class_assoc_test/",c$dateTime_frame,"/seg/",c$segment_name)
nd <- paste0("//nemo.hmsc.oregonstate.edu/PLANKTON LAB/OgdenFungREU/class_assoc_test/ClassifiedSegments/",c$class,"/",c$segment_name)
file.copy(from = od, to = nd)


    