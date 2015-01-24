# run_analysis.R 
# Written by: Julio A. Cartaya - Jan 23, 2015

# This script has been written to fulfill the Course Project requirement
# for Coursera's "Getting and Cleaning Data" (Johns Hopkins University,
# imparted by instructors Jeff Leeks, Roger D. Peng, Brian Caffo)

# This script should be run from the parent of the data archive documented at
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


# Load the needed libraries
suppressWarnings(library(dplyr))
suppressWarnings(library(tidyr))

# save, set working directory to the parent directory of the data, in my machine
OLDWD=getwd()
setwd("~/Coursera/GettingAndCleaningData")

# DATADIR is the slash-terminated directory where the data archive was extracted
DATADIR <- "UCI HAR Dataset/"

## Verify we have extracted the data in a subdirectory of wd
if(!file.exists(DATADIR) | !file.info(DATADIR)$isdir) stop (
  "Data directory missing. Script must run at parent of extracted data directory"
  )

## Auxiliary Function
# Define rcd_act() to convert activity codes into descriptive names
actName <- read.table(file=paste(DATADIR, "activity_labels.txt", sep=""))[,2]
rcd_act <- function(a) {
  a <- suppressWarnings(as.integer(a))
  if(is.na(a)) stop("Non-numeric activity code")
  if (a >= 1 & a <=length(actName)) return (actName[a])
  stop("Activity code out of bounds")
}

# Read DATADIR/colnames for datasets
dset_cols <- read.table(file=paste(DATADIR,"features.txt", sep=""))

## UNIFIED DATA TABLE
### "train" data set first
# Train set: read DATADIR/train/y_train.txt, translate, massage it into train_act (activities in set)
train_act <- read.table(file=paste(DATADIR,"train/y_train.txt", sep=""), col.names=c("act")) 

# Train set: read DATADIR/train/subject_train.txt into train_sub (subjects in the set)
train_sub <- read.table(file=paste(DATADIR,"train/subject_train.txt", sep=""), col.names=c("sub"))

# Train set: read DATADIR/train/X_train.txt into train_dat (temporary)
train_dat <- read.table(file=paste(DATADIR,"train/X_train.txt", sep=""))

# Train set: get train_tbl by binding columns on train_act, train_sub, and train_mea
train_tbl <- cbind(train_act,train_sub, train_dat)

# get rid of temporary tables
rm(train_act,train_sub,train_dat)

### "test" data set next
# Test set : read DATADIR/test/y_test.txt, translate, massage it into test_act (activities in set)
test_act <- read.table(file=paste(DATADIR,"test/y_test.txt", sep=""), col.names=c("act"))

# Test set : read DATADIR/test/subject_test.txt into test_sub
test_sub <- read.table(file=paste(DATADIR,"test/subject_test.txt", sep=""), col.names=c("sub"))

# Test set : read DATADIR/test/X_test.txt into test_dat (temporary)
test_dat <- read.table(file=paste(DATADIR,"test/X_test.txt", sep=""))

# Test set : get test_tbl by binding columns on test_act, test_sub, and test_mea
test_tbl <- cbind(test_act,test_sub, test_dat)

# get rid of temporary tables
rm(test_act, test_sub, test_dat)

### obtain uni_tbl (unified data set) 
#   by row-bindng train_tbl and test_tbl, then adding column names and eliminating
#   duplicates, keeping only those of no interest, and finally decoding activities

# rbind train_tbl, test_tbl to get tmp_tbl (temporary)
tmp_tbl <- rbind(train_tbl, test_tbl)
rm(train_tbl, test_tbl)

# add colnames
colnames(tmp_tbl) <- c("act", "sub", as.character(dset_cols[,2]))
rm(dset_cols)
# drop columns with duplicate names (not interesting anyway) 
# then select columns of interest
# then translate activities, using rcd_act
tmp_tbl[,!duplicated(colnames(tmp_tbl))] %>% select(act, sub, matches("-mean[(]|-std[(]")) %>%
 mutate(act=suppressWarnings(rcd_act(act))) -> uni_tbl
rm(rcd_act, tmp_tbl, actName)


##  TIDY DATA TABLE

# Unified set: aggregate, and remove redundant columns to obtain tidy table tdy_tbl
by1 <- uni_tbl[,1]
by2 <- uni_tbl[,2]
suppressWarnings(aggregate(uni_tbl, by=list(by1, by2), FUN=mean)) %>%
select(-act,-sub) -> tdy_tbl

## Rename columns in tdy_tbl
yy <- names(tdy_tbl)
zz <- c("ACT", "SUB", sub("^","AVG:",yy[3:ncol(tdy_tbl)]))
colnames(tdy_tbl) <- zz
rm(by1, by2, yy, zz)

# Write tdy_tbl, cleanup but leave tdy_tbl in place (for examination)
write.table(tdy_tbl, file="tdy_tbl.txt", row.names=FALSE)
setwd(OLDWD)