# =============================================================
# Title: Data Preparation
# Description:
#   This script performs cleaning tasks and transformations on
#   various columns of the raw data file.
# Input: data file 'nba2017-roster.csv' , 'nba2017-stats.csv'
# Output: data file 'nba2017-teams.csv'
# Author: Donggyun Kim
# Date: 2017-10-06
# =============================================================

# set working directory
setwd("/Users/donggyun/Desktop/STAT 133/stat133-hws-fall17/hw03/")

# pakages: "readr", "dplyr" and "ggplot2"
library(readr)
library(dplyr)
library(ggplot2)

# import csv files
roster <- read_csv("./data/nba2017-roster.csv")
stats <- read_csv("./data/nba2017-stats.csv")

# add new variable
stats %>% mutate(missed_fg = field_goals_atts - field_goals_made) # missed field goals
stats %>% mutate(missed_ft =) # missed free throws
stats %>% mutate(points = 3*points3_made + 2*points2_made + free_throw_made) # total points
stats %>% mutate(rebounds = off_rebounds + def_rebounds) # rebounds
stats %>% mutate((efficiency = points + rebounds + assists + steals + blocks
                 - missed_fg - missed_ft - turnovers) / games_played) # efficiency

# make summary
sink("./output/effiency-summary.txt")
summary(stats$efficiency)
sink()

# merge two data frames
roster_stats <- roster %>% 
  inner_join(stats)

