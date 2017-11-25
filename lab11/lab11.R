dat <- read.csv("mobile-food-sf.csv", stringsAsFactors = FALSE)

summary(dat)

library(stringr)

str(dat)

time1 <- "10AM"

str_sub(string = time1, start = 1, end = 2)
str_sub(string = time1, start = 3, end = 4)

times <- c("12PM", "10AM", "9AM", "8AM")

str_sub(times, 1, nchar(times) - 2)
str_sub(times, nchar(times) - 1, nchar(times))
str_sub(times, -2)

str_replace(string = times, pattern = "AM|PM", replacement = ":00")

hours <- as.numeric(str_replace(times, pattern = 'AM|PM', replacement = ''))
periods <- str_sub(times, start = -2)

hours

dat$start <- numeric(length(dat$starttime))
dat$end <- numeric(length(dat$endtime))
dat$duration <- character(length(dat$start))

for (i in 1 : length(dat$start)) {
  start <- dat$starttime[i]
  end <- dat$endtime[i]
  start_hour <- as.numeric(str_sub(start, 1, nchar(start) - 2))
  start_period <- str_sub(start, -2)
  end_hour <- as.numeric(str_sub(end, 1, nchar(end) - 2))
  end_period <- str_sub(end, -2)
  
  if (start_period == "PM") {
    start_hour <- start_hour + 12
  }
  
  if (end_period == "PM") {
    end_hour <- end_hour + 12
  }
  
  dat$start[i] <- start_hour
  dat$end[i] <- end_hour
  dat$duration[i] <- paste(start_hour, end_hour, sep = " ~ ")
}

loc1 <- "(37.7651967350509,-122.416451692902)"

str_replace_all(string = loc1, pattern = "\\(|\\)", replacement = "")

lat_lon <- str_replace_all(string = loc1, pattern ="\\(|\\)", replacement = "")

str_split(string = lat_lon, pattern = ",")

locs <- c(
  "(37.7651967350509,-122.416451692902)",
  "(37.7907890558203,-122.402273431333)",
  "(37.7111991003088,-122.394693339395)",
  "(37.7773000262759,-122.394812784799)",
  NA
)

locs <- str_replace_all(string = locs, pattern = "\\(|\\)", replacement = "")
lat_lon <- str_split(string = locs, pattern = ",")
lat_lon

lat <- lapply(lat_lon, FUN = function(x) x[1])
lat

lon <- lapply(lat_lon, FUN = function(x) x[2])
lon

locs <- dat$Location
locs <- str_replace_all(string = locs, pattern = "\\(|\\)", replacement = "")
lat_lon <- str_split(string = locs, pattern = ",")

lat <- lapply(lat_lon, FUN = function(x) x[1])
lon <- lapply(lat_lon, FUN = function(x) x[2])

dat$lat <- numeric(length(dat$Location))
dat$lon <- numeric(length(dat$Location))

dat$lat <- as.numeric(unlist(lat))
dat$lon <- as.numeric(unlist(lon))

plot(dat$lat, dat$lon)

library(RgoogleMaps)

center <- c(mean(dat$lat, na.rm = TRUE), mean(dat$lon, na.rm = TRUE))

zoom <- min(MaxZoom(range(dat$lat, na.rm = TRUE), 
                    range(dat$lon, na.rm = TRUE)))

map1 <- GetMap(center=center, zoom=zoom, destfile = "san-francisco.png")
PlotOnStaticMap(map1, dat$lat, dat$lon, col = "#ed4964", pch=20)

library(ggmap)

dat <- na.omit(dat)

sbbox <- make_bbox(lon = dat$lon, lat = dat$lat, f = .1)

sf_map <- get_map(location = sbbox, maptype = "terrain", source = "google")

ggmap(sf_map) + 
  geom_point(data = dat, 
             mapping = aes(x = lon, y = lat), 
             color = "red", alpha = 0.2, size = 1)

dat$optionaltext[1:3]

foods <- dat$optionaltext[1:10]

burritos <- dat[str_detect(dat$optionaltext, pattern = "Burritos|burritos"), ]

sbbox <- make_bbox(lon = burritos$lon, lat = burritos$lat, f = .1)

sf_map <- get_map(location = ssbox, maptype = "terrain", source = "google")

ggmap(sf_map) +
  geom_point(data = burritos,
             mapping = aes(x = lon, y = lat),
             color = "blue", alpha = 0.2, size = 1)

animals <- c('dog', 'cat', 'bird', 'dolphin', 'lion',
             'zebra', 'tiger', 'wolf', 'whale', 'eagle',
             'pig', 'osprey', 'kangaroo', 'koala')

grep('dog', animals)

grep('dog', animals, value = TRUE)

str_detect(animals, 'dog')

str_extract(animals, "dog")

str_detect(animals, pattern = "o*")

str_detect(animals, "o?")

animals[str_detect(animals, "o+")]
animals[str_detect(animals, "o{2}")]
animals[str_detect(animals, "[o][^oo]")]
animals[str_detect(animals, "[aeiou][aeiou]")]
animals[str_detect(animals, "[^aeiou][^aeiou]")]
animals[str_detect(animals, "[^aeiou][^aeiou][^aeiou]")]
animals[str_detect(animals, "^[a-z]{3}$")]
animals[str_detect(animals, "^[a-z]{4}$")]

files <- c('sales1.csv', 'orders.csv', 'sales2.csv',
           'sales3.csv', 'europe.csv', 'usa.csv', 'mex.csv',
           'CA.csv', 'FL.csv', 'NY.csv', 'TX.csv',
           'sales-europe.csv', 'sales-usa.csv', 'sales-mex.csv')

names <- str_sub(files, start = 1, end = -5)
names

files[str_detect(names, "\\d")]
files[!str_detect(names, "\\d")]
files[str_detect(names, "[a-z]")]
files[str_detect(names, "[A-Z]")]
files[str_detect(names, "\\-")]
files[!str_detect(names, "\\-")]

files_txt <- str_replace(files, pattern = "csv", replacement = "txt")
files_txt

str_split(files_txt, pattern = "\\.")

split_chars <- function(x) {
  str_split(x, pattern = "")
}

split_chars("Go Bears!")
split_chars("Expecto Patronum")

reverse_chars <- function(x) {
  x <- split_chars(x)
  y <- character(length(x[[1]]))
  for (i in 1 : length(x[[1]])) {
    y[length(x[[1]]) - i + 1] <- x[[1]][i]
  }
  reverse <- paste(y, collapse = "")
  reverse
}

reverse_chars("gattaca")
reverse_chars("Lumox Maxima")
