# =============================================================================
# Title: Data Preparation
# Description: 
#   This script performs cleaning task and transformations on various colums 
#   of the raw data file.
# Input: data file "rawscores.csv"
# Output: data file "cleanscores.csv"
# Author: Donggyun Kim
# Date: 2017-11-13
# =============================================================================

#load packages
library(readr)


#load functions
source("functions.R")

#load data file
mydat <- read_csv("../data/rawdata/rawscores.csv")

#save the structure of raw scores
sink("../output/summary-rawscores.txt")
cat(" The structure of raw scores\n")
str(mydat)

#initialize lists to save summary stats
stats_hw <- list(1)
stats_qz <- list(1)
stats_ex <- list(1)
stats_att <- summary_stats(mydat$ATT)

#assign statistics to list
for(i in 1:9){
  stats_hw[[i]] <- summary_stats(mydat[[i]])
}
for(i in 1:4){
  stats_qz[[i]] <- summary_stats(mydat[[i+10]])
}
for(i in 1:2){
  stats_ex[[i]] <- summary_stats(mydat[[i+14]])
}

#print all statistics
cat("\n\n The summary statistics of HW1\n")
print_stats(stats_hw[[1]])
cat("\n\n The summary statistics of HW2\n")
print_stats(stats_hw[[2]])
cat("\n\n The summary statistics of HW3\n")
print_stats(stats_hw[[3]])
cat("\n\n The summary statistics of HW4\n")
print_stats(stats_hw[[4]])
cat("\n\n The summary statistics of HW5\n")
print_stats(stats_hw[[5]])
cat("\n\n The summary statistics of HW6\n")
print_stats(stats_hw[[6]])
cat("\n\n The summary statistics of HW7\n")
print_stats(stats_hw[[7]])
cat("\n\n The summary statistics of HW8\n")
print_stats(stats_hw[[8]])
cat("\n\n The summary statistics of HW9\n")
print_stats(stats_hw[[9]])
cat("\n\n The summary statistics of ATT\n")
print_stats(stats_att)
cat("\n\n The summary statistics of QZ1\n")
print_stats(stats_qz[[1]])
cat("\n\n The summary statistics of QZ2\n")
print_stats(stats_qz[[2]])
cat("\n\n The summary statistics of QZ3\n")
print_stats(stats_qz[[3]])
cat("\n\n The summary statistics of QZ4\n")
print_stats(stats_qz[[4]])
cat("\n\n The summary statistics of EX1\n")
print_stats(stats_ex[[1]])
cat("\n\n The summary statistics of EX2\n")
print_stats(stats_ex[[2]])
sink()

#replace all missing values in the data set with zeros
for (i in 1:length(mydat)){
  x <- which(is.na(mydat[[i]])) #position of NA's
  mydat[[i]][x] <- 0 #replace NA with 0
}

#rescale scores of quizes and exams
mydat$QZ1 <- rescale100(mydat$QZ1, xmin = 0, xmax = 12)
mydat$QZ2 <- rescale100(mydat$QZ2, xmin = 0, xmax = 18)
mydat$QZ3 <- rescale100(mydat$QZ3, xmin = 0, xmax = 20)
mydat$QZ4 <- rescale100(mydat$QZ4, xmin = 0, xmax = 20)
mydat$Test1 <- rescale100(mydat$EX1, xmin = 0, xmax = 80) #add new Test1 variable
mydat$Test2 <- rescale100(mydat$EX2, xmin = 0, xmax = 90) #add new Test2 variable

#add new Lab variable
mydat$Lab <- numeric(length(mydat$HW1))
for(i in 1:length(mydat$Lab)){
  mydat$Lab[i] <- score_lab(mydat$ATT[i])
}

#add new Homework variable
mydat$Homework <- numeric(length(mydat$HW1)) #initialize the new variable
for(i in 1:length(mydat$Homework)){
  #create a vector consisting of homework scores
  hws <- c(mydat$HW1[i], mydat$HW2[i], mydat$HW3[i], mydat$HW4[i], mydat$HW5[i],
           mydat$HW6[i], mydat$HW7[i], mydat$HW8[i], mydat$HW9[i])
  hws <- drop_lowest(hws) #drop the lowest score
  mydat$Homework[i] <- get_average(hws) #takes the average of remaining scores
}

#add new Quiz variable
mydat$Quiz <- numeric(length(mydat$QZ1)) #initialize the new variable
for(i in 1:length(mydat$Quiz)){
  #create a vector consisting of quiz scores
  qzs <- c(mydat$QZ1[i], mydat$QZ2[i], mydat$QZ3[i], mydat$QZ4[i])
  qzs <- drop_lowest(qzs) #drop the lowest score
  mydat$Quiz[i] <- get_average(qzs) #takes the average of remaining scores
}

#add new Overall variable
mydat$Overall <- numeric(length(mydat$Test1)) #initialize the new variable
for(i in 1:length(mydat$Overall)){
  #create a vector consisting of lab, homework, quiz, and test scores
  ova <- c(0.1*mydat$Lab[i], 0.3*mydat$Homework[i], 0.15*mydat$Quiz[i], 
           0.2*mydat$Test1[i], 0.25*mydat$Test2[i])
  mydat$Overall[i] <- sum(ova)
}

#add new Grade variable
mydat$Grade <- character(length(mydat[[1]]))
for(i in 1:length(mydat$Grade)){
  myscore <- mydat$Overall[i]
  if (myscore >= 95 & myscore <= 100){
    mydat$Grade[i] <- "A+"
  }else if (myscore >= 90 & myscore < 95){
    mydat$Grade[i] <- "A"
  }else if (myscore >= 88 & myscore < 90){
    mydat$Grade[i] <- "A-"
  }else if (myscore >= 86 & myscore < 88){
    mydat$Grade[i] <- "B+"
  }else if (myscore >= 82 & myscore < 86){
    mydat$Grade[i] <- "B"
  }else if (myscore >= 79.5 & myscore < 82){
    mydat$Grade[i] <- "B-"
  }else if (myscore >= 77.5 & myscore < 79.5){
    mydat$Grade[i] <- "C+"
  }else if (myscore >= 70 & myscore < 77.5){
    mydat$Grade[i] <- "C"
  }else if (myscore >=60 & myscore < 70){
    mydat$Grade[i] <- "C-"
  }else if (myscore >= 50 & myscore < 60){
    mydat$Grade[i] <- "D"
  }else{
    mydat$Grade[i] <- "F"
  }
}

#define file names
file_name <- c("Lab", "Homework", "Quiz", "Test1", "Test2", "Overall")

#create function that save summary statistics
sink_summary <- function(data, name) {
  destination <- paste0("../output/", name, "-stats.txt")
  sink(destination)
  cat(paste0("The summary statistics of ", name, " score\n\n"))
  print_stats(summary_stats(data[[name]]))
  sink()
}

#save summary statistics of Test, Lab, Homework, Quiz, and Overall score
for(i in 1:length(file_name)) {
  sink_summary(mydat, file_name[i])
}

#save the structure of clean data frame
sink("../output/summary-cleanscores.txt")
str(mydat)
sink()

#export the clean data frame
write_csv(mydat, "../data/cleandata/cleanscores.csv")
