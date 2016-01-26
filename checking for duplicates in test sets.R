
#check for duplicates in the 20K test set generated using segments from transects 1W (d3) & 3W (d27) against Kaggle 60K segment data set

library("stringr")
library("dplyr")

#get file list for test set generated using files from transects 1W (d3) & 3W (d27)
wt.files <- list.files("C:/Users/kelly.robinson/Dropbox (HMSC - OSU)/OSTRICH_SparseConvNet/training_sets/Confusion Matrix_CCS_KaggleLibrary/Confusion Matrix files - sorted and unsorted/20k sorted images - finished/", pattern = ".jpg", recursive = T, full.names = F)

  wt <- as.data.frame(wt.files)
  colnames(wt) <- "dir"
  
  #get segement name
  t <- str_split_fixed(wt$dir, "/", 2)
  wt$wt.seg <- str_sub(t[,2])
  
  #check all segment names are unique
  wt.unique <- unique(wt$wt.seg)
  print(length(wt.unique))
 
  wt.seg <- wt[,c("wt.seg")]
  wt.seg <- as.data.frame(wt.seg)
  colnames(wt.seg) <- c("seg")
  
  
#get file list for Kaggle files
kaggle.files <- list.files("Z:/_Segments/Kaggle Segments_DO NOT TOUCH",pattern = ".jpg", recursive = T, full.names = F)
  
  kaggle <- as.data.frame(kaggle.files)
  colnames(kaggle) <- "dir"
  
  #get segement name
  t1 <- str_split_fixed(kaggle$dir, "/", 3)
  kaggle$kaggle.seg <- str_sub(t1[,3])
  
  #check all segment names are unique
  kaggle.unique <- unique(kaggle$kaggle.seg)
  print(length(kaggle.unique))
  
  kaggle.seg <- kaggle[,c("kaggle.seg")]
  kaggle.seg <- as.data.frame(kaggle.seg)
  colnames(kaggle.seg) <- "seg"
  
  #Return rows that are common between data frames
  duplicates <- semi_join(x = wt.seg, y = kaggle.seg, by = "seg")
  print(nrow(duplicates))
  
  #Return rows that are not duplicated between data frames
  not.duplicated <- anti_join(x = wt.seg, y = kaggle.seg, by = "seg")
  print(nrow(not.duplicated))
  
 