# load packages
library(XML)
library(xml2)
library(rvest)
library(magrittr)
library(stringr)


basket <- "https://www.basketball-reference.com"

# GSW
gsw <- "/teams/GSW/2017.html"
gsw_url <- paste0(basket, gsw)

download.file(gsw_url, "gsw-roster-2017.html")

gsw_roster <- readHTMLTable("gsw-roster-2017.html")


# BOS
bos <- "/teams/BOS/2017.html"
bos_url <- paste0(basket, bos)

download.file(bos_url, "bos-roster-2017.html")

bos_roster <- readHTMLTable("bos-roster-2017.html")

# NBA HTML
nba_html <- paste0(basket, "/leagues/NBA_2017.html")
xml_doc <- read_html(nba_html)

# extract values of nodes
xml_doc %>%
  html_nodes("h1") %>%
  html_text()

xml_doc %>%
  html_nodes("strong") %>%
  html_text()

xml_doc %>%
  html_nodes("button") %>%
  html_text()


# store the href attributes in a character vector
href <- xml_doc %>%
  html_nodes("table") %>%
  extract(1:2) %>%
  html_nodes("a") %>%
  html_attr("href")

xml_doc %>%
  html_nodes("table") %>%
  extract(1) %>%
  html_table()


# create another character vector containing just the team abbreviations
attr_team <- str_sub(href, start = 8, end = 10)

# create a character vector files with elements
file <- paste0(attr_team, "-roster-2017.csv")

# team url
team_url <- paste0(basket, href)

# store each table in its own csv file
for(i in seq(along = team_url)) {
  doc <- read_html(team_url[i])
  table <- doc %>%
    html_nodes("table") %>%
    html_table()
  write.csv(table, paste0("data/", file[i]))
}

# global table
DF <- read.csv(paste0("data/", file[1]))
DF$Team <- rep(attr_team[1], nrow(DF))

for (i in 2:30){
  df <- read.csv(paste0("data/", file[i]))     # read the file
  df$Team <- rep(attr_team[i], nrow(df))      # add Team column
  DF <- rbind(DF, df)     # append the current file
}

# save global table
write.csv(DF, "nba-rosters-2017.csv")
