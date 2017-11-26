#' @title remove missing value
#' @description remove missing values in numeric vectors
#' @param x a numeric vector
#' @return a numeric vector with no NA
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' remove_missing(a)
remove_missing <- function(x) {
  if (!is.numeric(x)) {
    stop("non-mumeric argument")
  }
  x <- x[!is.na(x)]
  x
}


#' @title minimum value
#' @description evaluate a minimum value from a numeric vector
#' @param x a numeric vector
#' @param na.rm a logical value showing whether missing values should be removed
#' @return a minimum value of a numeric vector
#' @return when na.rm = FALSE, NA if x has NA's
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' get_minimum(a, na.rm = TRUE)
get_minimum <- function(x, na.rm = FALSE) {
  if (!is.logical(na.rm)) {
    stop("non-logical value for `na.rm` argument")
  }
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  x <- sort(x, na.last = FALSE)
  min <- x[1]
  min
}


#' @title maximum value
#' @description evaluate a maximum value from a numeric vector
#' @param x a numeric vector
#' @param na.rm a logical value showing whether missing values should be removed
#' @return a maximum value of a numeric vector
#' @return when na.rm = FALSE, NA if x has NA's
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' get_maximum(a, na.rm = TRUE)
get_maximum <- function(x, na.rm = FALSE) {
  if (!is.logical(na.rm)) {
    stop("non-logical value for `na.rm` argument")
  }
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  x <- sort(x, na.last = TRUE)
  max <- x[length(x)]
  max
}


#' @title range value
#' @description evaluate a range value of a numeric vector
#' @param x a numeric vector
#' @param na.rm a logical value showing whether missing values should be removed
#' @return a range value of a numeric vector
#' @return when na.rm = FALSE, NA if x has NA's
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' get_range(a, na.rm = TRUE)
get_range <- function(x, na.rm = FALSE) {
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  get_maximum(x, na.rm) - get_minimum(x, na.rm)
}


#' @title median value
#' @description evaluate a median value of a numeric vector
#' @param x a numeric vector
#' @param na.rm a logical value showing whether missing values should be removed
#' @return a median value of a numeric vector
#' @return when na.rm = FALSE, NA if x has NA's
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' get_median(a, na.rm = TRUE)
get_median <- function(x, na.rm = FALSE) {
  if (!is.logical(na.rm)) {
    stop("non-logical value for `na.rm` argument")
  }
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  x <- sort(x, na.last = FALSE)
  if (is.na(x[1])) {
    return(x[1])
  }
  if (length(x) %% 2 == 0) {
    med <- (x[length(x)/2+1] + x[length(x)/2])/2
  }
  else {
    med <- x[(length(x)+1)/2]
  }
  med
}


#' @title average value
#' @description evaluate an average value of a numeric vector
#' @param x a numeric vector
#' @param na.rm a logical value showing whether missing values should be removed
#' @return an average value of a numeric vector
#' @return when na.rm = FALSE, NA if x has NA's
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' get_average(a, na.rm = TRUE)
get_average <- function(x, na.rm = FALSE) {
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  if (!is.logical(na.rm)) {
    stop("non-logical value for `na.rm` argument")
  }
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  x <- sort(x, na.last = FALSE)
  if (is.na(x[1])) {
    return(x[1])
  }
  sum <- numeric(1)
  for (i in 1:length(x)) {
    sum <- sum + x[i]
  }
  sum / length(x)
}


#' @title standard deviation
#' @description evaluate a standard deviation value of a numeric vector
#' @param x a numeric vector
#' @param na.rm a logical value showing whether missing value should be removed
#' @return a standard deviation value of a numeric vector
#' @return when na.rm = FALSE, NA if x has NA's
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' get_stdev(a, na.rm = TRUE)
get_stdev <- function(x, na.rm = FALSE) {
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  if (!is.logical(na.rm)) {
    stop("non-logical value for `na.rm` argument")
  }
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  x <- sort(x, na.last = FALSE)
  if (is.na(x[1])) {
    return(x[1])
  }
  sum <- numeric(1)
  avg <- get_average(x)
  for (i in 1:length(x)) {
    dif_square <- (x[i] - avg)^2
    sum <- sum + dif_square
  }
  sqrt(sum/(length(x)-1))
}


#' @title first quartile
#' @description evaluate the first quartile value of a numeric vector
#' @param x a numeric vector
#' @param na.rm a logical value showing whether missing value should be removed
#' @return the first quartile value of a numeric vector
#' @return when na.rm = FALSE, NA if x has NA's
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' get_quartile1(a, na.rm = TRUE)
get_quartile1 <- function(x, na.rm = FALSE) {
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  if (!is.logical(na.rm)) {
    stop("non-logical value for `na.rm` argument")
  }
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  x <- sort(x, na.last = FALSE)
  if (is.na(x[1])) {
    return(x[1])
  }
  quantile(x, probs = 0.25)[[1]]
}


#' @title third quartile
#' @description evaluate the third quartile value of a numeric vector
#' @param x a numeric vector
#' @param na.rm a logical value showing whether missing value should be removed
#' @return the third quartile value of a numeric vector
#' @return when na.rm = FALSE, NA if x has NA's
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' get_quartile3(a, na.rm = TRUE)
get_quartile3 <- function(x, na.rm = FALSE) {
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  if (!is.logical(na.rm)) {
    stop("non-logical value for `na.rm` argument")
  }
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  x <- sort(x, na.last = FALSE)
  if (is.na(x[1])) {
    return(x[1])
  }
  quantile(x, probs = 0.75)[[1]]
}


#' @title number of missing values
#' @description evaluate the number of missing values of a numeric vector
#' @param x a numeric vector
#' @return the number of missing values of a numeric vector
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' count_missing(a)
count_missing <- function(x) {
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  x <- x[is.na(x)]
  if (length(x) == 0) {
    return(0)
  }
  x[] <- 1
  sum <- numeric(1)
  for (i in 1:length(x)) {
    sum = sum + x[1]
  }
  sum
}


#' @title 10th percentile
#' @description evaluate the 10th percentile value of a numeric vector
#' @param x a numeric vector
#' @param na.rm a logical value showing whether missing values should be removed
#' @return the 10th percentile value of a numeric vector
#' @return when na.rm = FALSE, NA if x has NA's
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' get_percentile10(a, na.rm = TRUE)
get_percentile10 <- function(x, na.rm = FALSE) {
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  if (!is.logical(na.rm)) {
    stop("non-logical value for `na.rm` argument")
  }
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  x <- sort(x, na.last = FALSE)
  if (is.na(x[1])) {
    return(x[1])
  }
  quantile(x, 0.1)[[1]]
}


#' @title 90th percentile
#' @description evaluate the 90th percentile value of a numeric vector
#' @param x a numeric vector
#' @param na.rm a logical value showing whether missing values should be removed
#' @return the 90th percentile value of a numeric vector
#' @return when na.rm = FALSE, NA if x has NA's
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' get_percentile90(a, na.rm = TRUE)
get_percentile90 <- function(x, na.rm = FALSE) {
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  if (!is.logical(na.rm)) {
    stop("non-logical value for `na.rm` argument")
  }
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  x <- sort(x, na.last = FALSE)
  if (is.na(x[1])) {
    return(x[1])
  }
  quantile(x, 0.9)[[1]]
}


#' @title summary statistics
#' @description print a list of summary statistics
#' @param x a numeric vector
#' @return a list of minimum, 10th percentile, 1st quartile, median, mean, 
#' @return 3rd quartile, 90th percentile, maximum, range, standard deviation,
#' @return and missing values of a numeric vector
#' @example 
#' a <- c(1, 4, 7, NA, 10)
#' stats <- summary_stats(a)
#' stats
summary_stats <- function(x) {
  stats <- list(1)
  stats[1] <- get_minimum(x, na.rm = TRUE)
  stats[2] <- get_percentile10(x, na.rm = TRUE)
  stats[3] <- get_quartile1(x, na.rm = TRUE)
  stats[4] <- get_median(x, na.rm = TRUE)
  stats[5] <- get_average(x, na.rm = TRUE)
  stats[6] <- get_quartile3(x, na.rm = TRUE)
  stats[7] <- get_percentile90(x, na.rm = TRUE)
  stats[8] <- get_maximum(x, na.rm = TRUE)
  stats[9] <- get_range(x, na.rm = TRUE)
  stats[10] <- get_stdev(x, na.rm = TRUE)
  stats[11] <- count_missing(x)
  name <- c("minimum", "percent10", "quartile1", "median", "mean", 
            "quartile3", "percent90", "maximum", "range", "stdev",
            "missing")
  names(stats) <- name
  stats
}


#' @title summary statistics
#' @description print a nice format of summary statistics
#' @param x a list
#' @return a nice format of summary statistics
#' example
#' print_stats(stats)
print_stats <- function(x) {
  for (i in 1:length(x)) {
    x[[i]] <- format(round(x[[i]], 4), nsmall = 4)
  }
  names(x) <- format(names(x), width = max(nchar(names(x))))
  for (i in 1:length(x)) {
    cat(names(x)[i], x[[i]], sep = " : ", fill = TRUE)
  }
}


#' @title a potential scale
#' @description evaluate a potential scale from 0 to 100
#' @param x a numeric vector
#' @param xmin a minimum numeric value
#' @param xmax a maximum numeric value
#' @return a rescaled vector with a potential scale from 0 to 100
#' @example 
#' b <- c(18, 15, 16, 4, 17, 9)
#' rescale100(b, xmin = 0, xmax = 20)
rescale100 <- function(x, xmin, xmax) {
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  if (!is.numeric(xmin)) {
    stop("non-numeric value for `xmin` argument")
  }
  if (!is.numeric(xmax)) {
    stop("non-numeric value for `xmax` argument")
  }
  if (length(which(is.na(x[]) == TRUE)) > 0) {
    x <- remove_missing(x)
  }
  (x - xmin)/(xmax - xmin)*100
}


#' @title drop the lowest value
#' @description dropt the lowest value of a numeric vector
#' @param x a numeric vector
#' @return a numeric vector without the lowest value
#' @example 
#' b <- c(10, 10, 8.5, 4, 7, 9)
#' drop_lowest(b)
drop_lowest <- function(x) {
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  x[which.min(x)] <- NA
  x[!is.na(x)]
}


#' @title homework score
#' @description evaluate the average score of homework assignments
#' @param x a numeric vector
#' @param drop a logical value showing whether the lowest value should be dropped
#' @return the average value of a numeric vector
#' @example 
#' hws <- c(100, 80, 30, 70, 75, 85)
#' score_homework(hws, drop = TRUE)
#' score_homework(hws, drop = FALSE)
score_homework <- function(x, drop = FALSE) {
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  if (!is.logical(drop)) {
    stop("non-logical value for `drop` argument")
  }
  if (drop == FALSE) {
    get_average(x, na.rm = TRUE)
  } else {
    x <- drop_lowest(x)
    get_average(x)
  }
}


#' @title quiz score
#' @description evaluate the average socre of quizzes
#' @param x a numeric vector
#' @param drop a logical value showing whether the lowest value should be dropped
#' @return the average value of a numeric vector
#' @example 
#' quizzes <- c(100, 80, 70, 0)
#' score_quiz(quizzes, drop = TRUE)
#' score_quiz(quizzes, drop = FALSE)
score_quiz <- function(x, drop = FALSE) {
  if (!is.numeric(x)) {
    stop("non-numeric vector")
  }
  if (!is.logical(drop)) {
    stop("non-logical value for `drop` argument")
  }
  if (drop == FALSE) {
    get_average(x, na.rm = TRUE)
  } else {
    x <- drop_lowest(x)
    get_average(x)
  }
}


#' @title lab score
#' @description evaluate a rescaled lab score
#' @param x a numeric value
#' @return a rescaled numeric value from 0 to 100
#' @example 
#' score_lab(12)
#' score_lab(10)
#' score_lab(6)
score_lab <- function(x) {
  if (!is.numeric(x)) {
    stop("non-numeric value")
  }
  if (length(x) != 1) {
    stop("the length of a numeric vector should be 1")
  }
  if (x != as.integer(x)) {
    stop("no decimal value for this function")
  }
  if (x > 12) {
    stop("the numeric value should be between 0 and 12")
  } else if (x == 12 || x == 11) {
    return(100)
  } else if (x == 10) {
    return(80)
  } else if (x == 9) {
    return(60)
  } else if (x == 8) {
    return(40)
  } else if (x == 7) {
    return(20)
  } else if (x <= 6 || x >= 0) {
    return(0)
  } else {
    stop("the numeric value should be between 0 and 12")
  } 
}






