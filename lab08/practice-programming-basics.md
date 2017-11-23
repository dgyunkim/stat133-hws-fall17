Practice-Programming-Basics
================
Donggyun Kim
11/22/2017

1) Toggling Switches
--------------------

``` r
switches <- rep("off", 100)

# swap function that converts "off" into "on" vice versa
swap <- function(x) {
  switch(x,
       "off" = "on",
       "on" = "off")
}

for (i in 1:length(switches)) {
  for (j in seq(from = i, to = length(switches), by = i)) {
    switches[j] <- swap(switches[j])
  }
}

switches
```

    ##   [1] "on"  "off" "off" "on"  "off" "off" "off" "off" "on"  "off" "off"
    ##  [12] "off" "off" "off" "off" "on"  "off" "off" "off" "off" "off" "off"
    ##  [23] "off" "off" "on"  "off" "off" "off" "off" "off" "off" "off" "off"
    ##  [34] "off" "off" "on"  "off" "off" "off" "off" "off" "off" "off" "off"
    ##  [45] "off" "off" "off" "off" "on"  "off" "off" "off" "off" "off" "off"
    ##  [56] "off" "off" "off" "off" "off" "off" "off" "off" "on"  "off" "off"
    ##  [67] "off" "off" "off" "off" "off" "off" "off" "off" "off" "off" "off"
    ##  [78] "off" "off" "off" "on"  "off" "off" "off" "off" "off" "off" "off"
    ##  [89] "off" "off" "off" "off" "off" "off" "off" "off" "off" "off" "off"
    ## [100] "on"

2) Distance Matrix of Letters
-----------------------------

``` r
num_letters <- length(LETTERS)
set.seed(123)
values <- sample.int(num_letters)
distances <- values %*% t(values)
diag(distances) <- 0
dimnames(distances) <- list(LETTERS, LETTERS)
```

get\_dist function that returns a numerical value with the total distance.

``` r
get_dist <- function(distances, ltrs) {
  
  # logical vector shows whether ltrs contains upper letters or not
  logical <- ltrs %in% LETTERS
  
  # returns error message
  for (i in 1 : length(logical)) {
    if (logical[i] == FALSE) {
      stop("Unrecognized character")
    }
  }
  
  # returns a numerical value of the distance
  dis <- 0
  for (i in 1:length(ltrs)) {
    if (i < length(ltrs)) {
      dis <- dis + distances[ltrs[i], ltrs[i+1]]
    } else {
      break
    }
  }
  dis
}
```

test that the function works

``` r
vec <- c('E', 'D', 'A')
get_dist(distances, vec)
```

    ## [1] 651

test that the function throws error

``` r
err <- c('E', 'D', ')')
get_dist(distances, err)
```

    ## Error in get_dist(distances, err): Unrecognized character

test with other character vectors

``` r
cal <- c('C', 'A', 'L')
get_dist(distances, cal)
```

    ## [1] 136

``` r
stats <- c('S', 'T', 'A', 'T', 'S')
get_dist(distances, stats)
```

    ## [1] 990

``` r
oski <- c('O', 'S', 'K', 'I')
get_dist(distances, oski)
```

    ## [1] 834

``` r
zzz <- rep('Z', 3)
get_dist(distances, zzz)
```

    ## [1] 0

``` r
lets <- LETTERS
get_dist(distances, lets)
```

    ## [1] 4800

``` r
first <- c('D', 'O', 'N', 'G', 'G', 'Y', 'U', 'N')
get_dist(distances, first)
```

    ## [1] 607

``` r
last <- c('K', 'I', 'M')
get_dist(distances, last)
```

    ## [1] 816

apply the function to a character list

``` r
strings <- list(
  cal = cal,
  stats = stats,
  oski = oski,
  zzz = zzz,
  lets = lets,
  first = first,
  last = last
)

strings_dists <- strings
for (i in 1 : length(strings)) {
  strings_dists[[i]] <- get_dist(distances, strings[[i]])
}

strings_dists
```

    ## $cal
    ## [1] 136
    ## 
    ## $stats
    ## [1] 990
    ## 
    ## $oski
    ## [1] 834
    ## 
    ## $zzz
    ## [1] 0
    ## 
    ## $lets
    ## [1] 4800
    ## 
    ## $first
    ## [1] 607
    ## 
    ## $last
    ## [1] 816

3) Vending Machine
------------------

create data frame

``` r
brand <- c(rep("cliff", 4), rep("mars", 4), rep("luna", 4), rep("nabisco", 4))
bar <- c("peanut-toffee", "brownie", "carrot-cake", "oatmeal-raisin", "m&m", 
         "kit-kat", "hersheys", "snickers", "blueberry", "lemonzest",
         "vanilla", "cookies", "chips-ahoy", "oreo", "ritz", "nutter-butter")
price <- c(rep(1.6, 4), rep(1.8, 4), rep(1.5, 4), rep(1.7, 4))
letter <- c(rep(LETTERS[1:4] , 4))
number <- c(rep(1, 4), rep(2, 4), rep(3, 4), rep(4, 4))

dat <- data.frame(brand, bar, price, letter, number, stringsAsFactors = FALSE)
```

create `show_price` function

``` r
show_price <- function(products, letter, number) {
  list(
    bar = products$bar[products$letter == letter & products$number == number],
    price = products$price[products$letter == letter & products$number == number]
  )
  
}
```

test `show_price` function

``` r
show_price(dat, letter = "A", number = 1)
```

    ## $bar
    ## [1] "peanut-toffee"
    ## 
    ## $price
    ## [1] 1.6

create `buy_item` function

``` r
buy_item <- function(products, letter = "A", number = 1, money = 0) {
  list <- show_price(products, letter, number)
  list$money <- money
  list$change <- list$money - list$price
  
  if (list$change < 0) {
    stop("not enough money")
  }
  
  list
}
```

test `buy_item` function

``` r
buy_item(dat, letter = 'A', number = 1, money = 2)
```

    ## $bar
    ## [1] "peanut-toffee"
    ## 
    ## $price
    ## [1] 1.6
    ## 
    ## $money
    ## [1] 2
    ## 
    ## $change
    ## [1] 0.4

``` r
buy_item(dat, letter = 'A', number = 1, money = 1.4)
```

    ## Error in buy_item(dat, letter = "A", number = 1, money = 1.4): not enough money

4) Currency Converter
---------------------

create `exchange` function

``` r
exchange <- function(amount = 1, from = "dollar", to = "euro") {
  # vector of dollar exchange rates
  x <- c(
    dollar = 1,
    euro = 0.849,
    pound = 0.758,
    yen = 112.18,
    yuan = 6.62,
    won = 1131.17,
    rupee = 64.95,
    peso = 18.75,
    real = 3.159
    )
  
  x <- switch(from,
         "dollar" = x,
         "euro" = x / 0.849,
         "pound" = x / 0.758,
         "yen" = x / 112.18,
         "yuan" = x / 6.62,
         "won" = x / 1131.17,
         "rupee" = x / 64.95,
         "peso" = x / 18.75,
         "real" = x / 3.159
         )
  
  amount * x[to]
  
}
```

test `exchange` function

``` r
exchange()
```

    ##  euro 
    ## 0.849

``` r
# various conversions
exchange(amount = 10, from = 'euro', to = 'peso')
```

    ##     peso 
    ## 220.8481

``` r
exchange(amount = 20, from = 'yuan', to = 'pound')
```

    ##   pound 
    ## 2.29003

``` r
exchange(amount = 30, from = 'rupee', to = 'won')
```

    ##      won 
    ## 522.4804

5) Distances in Euclidean Spaces
--------------------------------

create `minkowski` function

``` r
minkowski <- function(point1, point2, p = 1) {
  sum <- 0
  for (i in 1 : length(point1)) {
    sum <- sum + abs((point1[i] - point2[i])^p)
  }
  sum^(1/p)
}
```

test `minkowski` function

``` r
point1 <- c(0, 0)
point2 <- c(1, 1)

minkowski(point1, point2, p = 1)
```

    ## [1] 2

``` r
minkowski(point1, point2, p = 2)
```

    ## [1] 1.414214

6) Two Given Points
-------------------

create `find_distance` function

``` r
find_distance <- function(p1, p2) {
  sum <- 0
  for (i in 1 : length(p1)) {
    sum <- sum + (p2[i] - p1[i])^2
  }
  sqrt(sum)
}
```

test `find_distance` function

``` r
p1 <- c(0, 0)
p2 <- c(1, 1)
find_distance(p1, p2)
```

    ## [1] 1.414214

create `find_midpoint` function

``` r
find_midpoint <- function(p1, p2) {
  p <- rep(0, length(p1))
  for (i in 1 : length(p1)) {
    p[i] <- (p1[i] + p2[i]) / 2
  }
  p
}
```

test `find_midpoint` function

``` r
p1 <- c(0, 0)
p2 <- c(1, 1)
find_midpoint(p1, p2)
```

    ## [1] 0.5 0.5

create `find_slope` function

``` r
find_slope <- function(p1, p2) {
  (p2[2] - p1[2]) / (p2[1] - p1[1])
}
```

test `find_slope` function

``` r
p1 <- c(0, 0)
p2 <- c(1, 1)
find_slope(p1, p2)
```

    ## [1] 1

create `find_intercept` function

``` r
find_intercept <- function(p1, p2) {
  p1[2] - find_slope(p1, p2) * p1[1]
}
```

test `find_intercept` function

``` r
p1 <- c(0, 0)
p2 <- c(1, 1)
find_intercept(p1, p2)
```

    ## [1] 0

create `find_line` function

``` r
find_line <- function(p1, p2) {
  list(
    intercept = find_intercept(p1, p2),
    slope = find_slope(p1, p2)
  )
}
```

test `find_line` function

``` r
p1 <- c(0, 0)
p2 <- c(1, 1)
eq <- find_line(p1, p2)
eq$intercept
```

    ## [1] 0

``` r
eq$slope
```

    ## [1] 1

create `info_points` function

``` r
info_points <- function(p1, p2) {
  info <- find_line(p1, p2)
  info$distance <- find_distance(p1, p2)
  info$midpoint <- find_midpoint(p1, p2)
  info
}
```

test `info_points` function

``` r
p1 <- c(-2, 4)
p2 <- c(1, 2)
results <- info_points(p1, p2)
results$distance
```

    ## [1] 3.605551

``` r
results$midpoint
```

    ## [1] -0.5  3.0

``` r
results$intercept
```

    ## [1] 2.666667

``` r
results$slope
```

    ## [1] -0.6666667
