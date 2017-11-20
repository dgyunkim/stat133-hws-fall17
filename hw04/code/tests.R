library(testthat)
source("functions.R")


context("remove_missing function")

test_that("remove_missing works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  expect_equal(remove_missing(a), c(1, 4, 7, 10))
  expect_equal(remove_missing(b), c(1, 4, 7, 10))
  expect_length(remove_missing(a), 4)
  expect_type(remove_missing(a), "double")
})

test_that("remove_missing throws error", {
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(remove_missing(char))
  expect_error(remove_missing(logi))
})


context("get_minimum function")

test_that("get_minimum works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  expect_equal(get_minimum(a, na.rm = TRUE), 1)
  expect_equal(as.logical(get_minimum(a)), NA)
  expect_equal(get_minimum(b), 1)
  expect_length(get_minimum(b), 1)
  expect_type(get_minimum(b), "double")
})

test_that("get_minimum throws error", {
  b <- c(1, 4, 7, 10)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(get_minimum(b, na.rm = 8))
  expect_error(get_minimum(char))
  expect_error(get_minimum(logi))
})


context("get_maximum function")

test_that("get_maximum works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  expect_equal(get_maximum(a, na.rm = TRUE), 10)
  expect_equal(as.logical(get_maximum(a)), NA)
  expect_equal(get_maximum(b), 10)
  expect_length(get_maximum(b), 1)
  expect_type(get_maximum(b), "double")
})

test_that("get_maximum throws error", {
  b <- c(1, 4, 7, 10)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(get_maximum(b, na.rm = 8))
  expect_error(get_maximum(char))
  expect_error(get_maximum(logi))
})


context("get_range function")

test_that("get_range works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  expect_equal(get_range(a, na.rm = TRUE), 9)
  expect_equal(as.logical(get_range(a)), NA)
  expect_equal(get_range(b), 9)
  expect_length(get_range(b), 1)
  expect_type(get_range(b), "double")
})

test_that("get_range throws error", {
  b <- c(1, 4, 7, 10)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(get_range(b, na.rm = 8))
  expect_error(get_range(char))
  expect_error(get_range(logi))
})


context("get_median function")

test_that("get_median works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  expect_equal(get_median(a, na.rm = TRUE), (7+4)/2)
  expect_equal(as.logical(get_median(a)), NA)
  expect_equal(get_median(b), (7+4)/2)
  expect_length(get_median(b), 1)
  expect_type(get_median(b), "double")
})

test_that("get_median throws error", {
  b <- c(1, 4, 7, 10)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(get_median(b, na.rm = 8))
  expect_error(get_median(char))
  expect_error(get_median(logi))
})


context("get_average function")

test_that("get_average works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  expect_equal(get_average(a, na.rm = TRUE), (1 + 4 + 7 + 10)/4)
  expect_equal(as.logical(get_average(a)), NA)
  expect_equal(get_average(b), (1 + 4 + 7 + 10)/4)
  expect_length(get_average(b), 1)
  expect_type(get_average(b), "double")
})

test_that("get_average throws error", {
  b <- c(1, 4, 7, 10)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(get_average(b, na.rm = 8))
  expect_error(get_average(char))
  expect_error(get_average(logi))
})


context("get_stdev function")

test_that("get_stdev works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  c <- (((1 - 5.5)^2 + (4 - 5.5)^2 + (7 - 5.5)^2 + (10 - 5.5)^2)/3)^(1/2)
  expect_equal(get_stdev(a, na.rm = TRUE), c)
  expect_equal(as.logical(get_stdev(a)), NA)
  expect_equal(get_stdev(b), c)
  expect_length(get_stdev(b), 1)
  expect_type(get_stdev(b), "double")
})

test_that("get_stdev throws error", {
  b <- c(1, 4, 7, 10)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(get_stdev(b, na.rm = 8))
  expect_error(get_stdev(char))
  expect_error(get_stdev(logi))
})


context("get_quartile1 function")

test_that("get_quartile1 works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  expect_equal(get_quartile1(a, na.rm = TRUE), 3.25)
  expect_equal(as.logical(get_quartile1(a)), NA)
  expect_equal(get_quartile1(b), 3.25)
  expect_length(get_quartile1(b), 1)
  expect_type(get_quartile1(b), "double")
})

test_that("get_quartile1 throws error", {
  b <- c(1, 4, 7, 10)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(get_quartile1(b, na.rm = 8))
  expect_error(get_quartile1(char))
  expect_error(get_quartile1(logi))
})


context("get_quartile3 function")

test_that("get_quartile3 works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  expect_equal(get_quartile3(a, na.rm = TRUE), 7.75)
  expect_equal(as.logical(get_quartile3(a)), NA)
  expect_equal(get_quartile3(b), 7.75)
  expect_length(get_quartile3(b), 1)
  expect_type(get_quartile3(b), "double")
})

test_that("get_quartile3 throws error", {
  b <- c(1, 4, 7, 10)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(get_quartile3(b, na.rm = 8))
  expect_error(get_quartile3(char))
  expect_error(get_quartile3(logi))
})


context("count_missing function")

test_that("count_missing works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  expect_equal(count_missing(a), 1)
  expect_equal(count_missing(b), 0)
  expect_length(count_missing(b), 1)
  expect_type(count_missing(b), "double")
})

test_that("count_missing throws error", {
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(count_missing(char))
  expect_error(count_missing(logi))
})


context("get_percentile10 function")

test_that("get_percentile10 works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  expect_equal(get_percentile10(a, na.rm = TRUE), 1.9)
  expect_equal(as.logical(get_percentile10(a)), NA)
  expect_equal(get_percentile10(b), 1.9)
  expect_length(get_percentile10(b), 1)
  expect_type(get_percentile10(b), "double")
})

test_that("get_percentile10 throws error", {
  b <- c(1, 4, 7, 10)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(get_percentile10(b, na.rm = 8))
  expect_error(get_percentile10(char))
  expect_error(get_percentile10(logi))
})


context("get_percentile90 function")

test_that("get_percentile90 works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  expect_equal(get_percentile90(a, na.rm = TRUE), 9.1)
  expect_equal(as.logical(get_percentile90(a)), NA)
  expect_equal(get_percentile90(b), 9.1)
  expect_length(get_percentile90(b), 1)
  expect_type(get_percentile90(b), "double")
})

test_that("get_percentile90 throws error", {
  b <- c(1, 4, 7, 10)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(get_percentile90(b, na.rm = 8))
  expect_error(get_percentile90(char))
  expect_error(get_percentile90(logi))
})


context("summary_stats function")

test_that("summary_stats works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  expect_equal(summary_stats(a)$minimum, get_minimum(a, na.rm = TRUE))
  expect_equal(summary_stats(a)$percent10, get_percentile10(a, na.rm = TRUE))
  expect_equal(summary_stats(a)$quartile1, get_quartile1(a, na.rm = TRUE))
  expect_equal(summary_stats(a)$median, get_median(a, na.rm = TRUE))
  expect_equal(summary_stats(a)$mean, get_average(a, na.rm = TRUE))
  expect_equal(summary_stats(a)$quartile3, get_quartile3(a, na.rm = TRUE))
  expect_equal(summary_stats(a)$percent90, get_percentile90(a, na.rm = TRUE))
  expect_equal(summary_stats(a)$maximum, get_maximum(a, na.rm = TRUE))
  expect_equal(summary_stats(a)$range, get_range(a, na.rm = TRUE))
  expect_equal(summary_stats(a)$stdev, get_stdev(a, na.rm = TRUE))
  expect_equal(summary_stats(a)$missing, count_missing(a))
  expect_equal(summary_stats(b)$minimum, get_minimum(b))
  expect_equal(summary_stats(b)$percent10, get_percentile10(b))
  expect_equal(summary_stats(b)$quartile1, get_quartile1(b))
  expect_equal(summary_stats(b)$median, get_median(b))
  expect_equal(summary_stats(b)$mean, get_average(b))
  expect_equal(summary_stats(b)$quartile3, get_quartile3(b))
  expect_equal(summary_stats(b)$percent90, get_percentile90(b))
  expect_equal(summary_stats(b)$maximum, get_maximum(b))
  expect_equal(summary_stats(b)$range, get_range(b))
  expect_equal(summary_stats(b)$stdev, get_stdev(b))
  expect_equal(summary_stats(b)$missing, count_missing(b))
  expect_length(summary_stats(a), 11)
  expect_length(summary_stats(b), 11)
  expect_type(summary_stats(a), "list")
  expect_type(summary_stats(b), "list")
})

test_that("summary_stats throws error", {
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(summary_stats(char))
  expect_error(summary_stats(logi))
})


context("print_stats function")

test_that("print_stats works", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  stat_a <- summary_stats(a)
  stat_b <- summary_stats(b)
  expect_output(print_stats(stat_a), "mean      : 5.5000")
  expect_output(print_stats(stat_b), "mean      : 5.5000")
  expect_output(print_stats(stat_a), "maximum   : 10.0000")
  expect_output(print_stats(stat_b), "maximum   : 10.0000")
  expect_output(print_stats(stat_a), "missing   : 1.0000")
  expect_output(print_stats(stat_b), "missing   : 0.0000")
})

test_that("print_stats throws error", {
  a <- c(1, 4, 7, NA, 10)
  b <- c(1, 4, 7, 10)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(print_stats(a))
  expect_error(print_stats(b))
  expect_error(print_stats(char))
  expect_error(print_stats(logi))
})


context("rescale100 function")

test_that("rescale100 works", {
  a <- c(18, 15, 16, NA, 4, 17, 9)
  b <- c(18, 15, 16, 4, 17, 9)
  expect_equal(rescale100(a, xmin = 0, xmax = 20), c(90, 75, 80, 20, 85, 45))
  expect_equal(rescale100(b, xmin = 0, xmax = 20), c(90, 75, 80, 20, 85, 45))
  expect_length(rescale100(a, xmin = 0, xmax = 20), length(remove_missing(a)))
  expect_length(rescale100(b, xmin = 0, xmax = 20), length(b))
  expect_type(rescale100(a, xmin = 0, xmax = 20), "double")
  expect_type(rescale100(b, xmin = 0, xmax = 20), "double")
})

test_that("rescale100 thorows error", {
  a <- c(18, 15, 16, NA, 4, 17, 9)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(rescale100(a))
  expect_error(rescale100(a, xmin = char))
  expect_error(rescale100(a, xmax = logi))
  expect_error(rescale100(char))
  expect_error(rescale100(logi))
})


context("drop_lowest function")

test_that("drop_lowest works", {
  a <- c(18, 15, 16, NA, 4, 17, 9)
  b <- c(18, 15, 16, 4, 17, 9)
  expect_equal(drop_lowest(a), c(18, 15, 16, 17, 9))
  expect_equal(drop_lowest(b), c(18, 15, 16, 17, 9))
  expect_length(drop_lowest(a), length(a) - 2)
  expect_length(drop_lowest(b), length(b) - 1)
  expect_type(drop_lowest(a), "double")
  expect_type(drop_lowest(b), "double")
})

test_that("drop_lowest throws error", {
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(drop_lowest(char))
  expect_error(drop_lowest(logi))
})


context("score_homework function")

test_that("score_homework works", {
  a <- c(100, 80, 30, 70, 75, 85)
  b <- c(100, 80, 30, NA, 70, 75, 85)
  expect_equal(score_homework(a), get_average(a))
  expect_equal(score_homework(b), get_average(b, na.rm = TRUE))
  expect_equal(score_homework(a, drop = TRUE), get_average(drop_lowest(a)))
  expect_equal(score_homework(b, drop = TRUE), get_average(drop_lowest(b)))
  expect_length(score_homework(a), 1)
  expect_length(score_homework(b), 1)
  expect_type(score_homework(a), "double")
  expect_type(score_homework(b), "double")
})

test_that("score_homework throws error", {
  a <- c(100, 80, 30, 70, 75, 85)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(score_homework(a, drop = 8))
  expect_error(score_homework(char))
  expect_error(score_homework(logi))
})


context("score_quiz function")

test_that("score_quiz works", {
  a <- c(100, 80, 70, 0)
  b <- c(100, 80, NA, 70, 0)
  expect_equal(score_quiz(a), get_average(a))
  expect_equal(score_quiz(b), get_average(b, na.rm = TRUE))
  expect_equal(score_quiz(a, drop = TRUE), get_average(drop_lowest(a)))
  expect_equal(score_quiz(b, drop = TRUE), get_average(drop_lowest(b)))
  expect_length(score_quiz(a), 1)
  expect_length(score_quiz(b), 1)
  expect_type(score_quiz(a), "double")
  expect_type(score_quiz(b), "double")
})

test_that("score_quiz throws error", {
  a <- c(100, 80, 70, 0)
  char <- letters[1:2]
  logi <- c(TRUE, FALSE)
  expect_error(score_quiz(a, drop = 8))
  expect_error(score_quiz(char))
  expect_error(score_quiz(logi))
})


context("score_lab function")

test_that("score_lab works", {
  expect_equal(score_lab(12), 100)
  expect_equal(score_lab(10), 80)
  expect_equal(score_lab(9), 60)
  expect_equal(score_lab(8), 40)
  expect_equal(score_lab(7), 20)
  expect_equal(score_lab(6), 0)
  expect_length(score_lab(10), 1)
  expect_type(score_lab(8), "double")
})

test_that("score_lab throws error", {
  expect_error(score_lab("a"))
  expect_error(score_lab(TRUE))
  expect_error(score_lab(11.11))
})
