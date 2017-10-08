# =============================================================
# Title: Data Preparation
# Description:
#   This script performs cleaning tasks and transformations on
#   various columns of the raw data file.
# Input: data file 'nba2017-roster.csv' , 'nba2017-stats.csv'
# Output: data file 'nba2017-teams.csv'
# Author: Donggyun Kim
# Date: 2017-10-07
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

# replace NA to 0
stats$points3_perc[is.na(stats$points3_perc)] <- 0
stats$points2_perc[is.na(stats$points2_perc)] <- 0
stats$points1_perc[is.na(stats$points1_perc)] <- 0


# add new variable
stats <- stats %>% mutate(missed_fg = field_goals_atts - field_goals_made) # missed field goals
stats <- stats %>% mutate(missed_ft = points1_atts - points1_made) # missed free throws
stats <- stats %>% mutate(points = 3*points3_made + 2*points2_made + points1_made) # total points
stats <- stats %>% mutate(rebounds = off_rebounds + def_rebounds) # rebounds
stats <- stats %>% mutate(efficiency = (points + rebounds + assists + steals + 
                             blocks - missed_fg - missed_ft - turnovers) / games_played) # efficiency

# make summary
sink("./output/effiency-summary.txt")
summary(stats$efficiency)
sink()

# merge two data frames
roster_stats <- roster %>% 
  inner_join(stats)

# creat a data frame, teams
teams <- roster_stats %>%
  group_by(team) %>%
  summarise(weight = round(mean(weight), 2), height = round(mean(height), 2), experience = sum(experience),
            salary = round(sum(salary) / 1000000, 2), age = sum(age), 
            points3 = sum(points3_made), points2 = sum(points2_made),
            free_throws = sum(points1_made), points = sum(points), 
            points3_perc = mean(points3_perc), points2_perc = mean(points2_perc),
            points1_perc = mean(points1_perc), off_rebounds = sum(off_rebounds), 
            def_rebounds = sum(def_rebounds), assists = sum(assists), 
            steals = sum(steals), blocks = sum(blocks), turnovers = sum(turnovers),
            fouls = sum(fouls), efficiency = sum(efficiency))

# summary text file
sink("./output/teams-summary.txt")
summary(teams)
sink()

# export teams as a csv file
write_csv(teams, "./data/nba2017_teams.csv")

# save a star plot of teams
pdf("./images/teams_star_plot.pdf")
stars(teams[, -1], labels = teams$team)
dev.off()

# save a scatterplot of experience and salary
pdf("./images/experience_salary.pdf")
ggplot(data = teams, aes(x = experience, y = salary))+geom_point()+
  geom_text(aes(label = teams$team), nudge_x = 2, nudge_y = 2)
dev.off()

