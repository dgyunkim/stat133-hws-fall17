# =============================================================
# Title: Cleaning Data
# Description:
#   This script performs cleaning tasks and transformations on
#   various columns of the raw data file.
# Input: data file 'nba2017-players.csv'
# Output: data file 'nba2017.csv'
# Author: Donggyun Kim
# Date: 2017-10-05
# =============================================================

# pakages
library(readr)    # importing data
library(dplyr)    # data wrangling
library(ggplot2)  # graphics

# set working directory
setwd("~/Desktop/STAT 133/stat133-hws-fall17/lab06")

# load the raw data
nba2017 <- read_csv("~/Desktop/STAT 133/stat133-hws-fall17/lab06/data/nba2017-players.csv")

# create data frame for Warriors
warriors <- nba2017%>%filter(team == "GSW")%>%arrange(salary)
attributes(warriors)$row.names <- warriors$player

# save 'warriors' data frame
write.csv(warriors, "./data/warriors.csv")

# create data frame for Lakers
lakers <- nba2017%>%filter(team == "LAL")%>%arrange(desc(experience))

# save 'lakers' data frame
write_csv(lakers, "./data/lakers.csv")

# divert output to the specified file
sink(file = "./output/data-structure.txt")
str(nba2017)
sink()

sink(file = "./output/summary-warriors.txt")
summary(warriors)
sink()

sink(file = "./output/summary-lakers.txt")
summary(lakers)
sink()

# save image files
png(filename = "./images/scatterplot-height-weight.png")
plot(nba2017$height, nba2017$weight, pch = 21, xlab = "Height", ylab = "Weight")
dev.off()

png(filename = "./images/high-resolution-height-weight.png", height = 800, width = 800, res = 150)
plot(nba2017$height, nba2017$weight, pch = 21, xlab = "Height", ylab = "Weight")
dev.off()

jpeg(filename = "./images/histogram-age.jpeg", width = 600, height = 400)
hist(nba2017$age, xlab = "Age", main = "Histogram of age")
dev.off()

pdf(file = "./images/histogram-age.pdf", width = 7, height = 5)
hist(nba2017$age, xlab = "Age", main = "Histogram of age")
dev.off()

ggplot(nba2017, aes(x = points, y = salary))+geom_point()
ggsave("./images/points_salary.pdf", device = "pdf", width = 7, height = 5, units = "in")

gg_ht_wt_positions <- ggplot(nba2017, aes(x = height, y = weight))+geom_point()+facet_wrap(~ position)
ggsave("./images/height_weight_by_position.pdf", plot = gg_ht_wt_positions, device = "pdf", 
       width = 6, height = 4, units = "in")

# display the player names of Lakers
nba2017 %>%
  filter(team == "LAL") %>%
  select(player)

# display the name and salary of GSW point guards 'PG'
nba2017 %>%
  filter(team == "GSW") %>%
  select(player, salary)

# dislay the name, age, and team, of players with more than 10 years of experience, 
# making 10 million dollars or less.
nba2017 %>%
  filter(experience > 10 & salary <= 1000000) %>%
  select(player, age, team)

# select the name, team, height, and weight, of rookie players, 20 years old, 
# displaying only the first five occurrences
nba2017 %>%
  filter(experience == 0 & age == 20) %>%
  select(player, team, height, weight) %>%
  head(5)
  
# create a data frame gsw_mpg of GSW players, that contains variables for player name, 
# experience, and min_per_game (minutes per game), sorted by min_per_game (in descending order)
gsw_mpg <- nba2017 %>%
  filter(team == "GSW") %>%
  mutate(min_per_game = minutes / games) %>%
  select(player, experience, min_per_game) %>%
  arrange(desc(min_per_game))

# display the average triple points by team, in ascending order, of the bottom-5 teams (worst 3pointer teams)
nba2017 %>%
  group_by(team) %>%
  summarise(avg_three = mean(points3)) %>%
  arrange(avg_three) %>%
  head(5)

# obtain the mean and standard deviation of age, for Power Forwards, 
# with 5 and 10 years (including) years of experience
nba2017 %>%
  filter(experience >= 5 & experience <= 10 & position == "PF") %>%
  summarise(mean_age = mean(age), sd_age = sd(age))
