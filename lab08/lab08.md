lab08
================
Donggyun Kim
10/19/2017

``` r
vec <- c(3, 1, 4) 

for (j in 1:3 ){
  print(vec[j])
}
```

    ## [1] 3
    ## [1] 1
    ## [1] 4

``` r
vec <- c(3, 1, 4)  
vec2 <- rep(0, length(vec)) 

for (i in 1:length(vec)) {
  vec2[i] <- vec[i]*3
}

vec2
```

    ## [1]  9  3 12

Summation Series

``` r
summation <- function (n = 0) {
  sum = 0
  for (k in 0 : n) {
    sum <-  sum + 1/2^k
  }
  sum
}

summation()
```

    ## [1] 1

``` r
summation(2)
```

    ## [1] 1.75

``` r
summation(100)
```

    ## [1] 2

``` r
summation(10000)
```

    ## [1] 2

``` r
summation2 <- function (n = 0) {
  sum = 0
  for (k in 0 : n) {
    sum <- sum + 1/9^k
  }
  sum
}

summation2()
```

    ## [1] 1

``` r
summation2(2)
```

    ## [1] 1.123457

``` r
summation2(100)
```

    ## [1] 1.125

``` r
summation2(10000)
```

    ## [1] 1.125

Arithmetic Series

``` r
arithmetic <- function (n = 1) {
  a1 = 3
  d = 3
  sum = 0
  for (i in 1 : n) {
    an = a1 + (i-1)*d
    sum = sum + an
  }
  sum
}
```

Geometric Sequence

``` r
geometric <- function (n = 1) {
  a1 = 3
  r = 3
  sum = 0
  vec = rep(0, length(n))
  for (i in 1 : n) {
    an = a1 * r^(i-1)
    sum = sum + an
    vec[i] = sum
  }
  print(sum)
  vec
}
```

Sine Approximation

``` r
sine <- function (x = 0, n = 1) {
  sum = 0
  for (i in 1 : n) {
    an = (-1)^(i-1)*x^(2*i-1)/factorial(2*i-1)
    sum = sum + an
    }
  sum
}
sine(pi/2, 5)
```

    ## [1] 1.000004

``` r
sine(pi/2, 10)
```

    ## [1] 1

``` r
sine(pi/2, 50)
```

    ## [1] 1

``` r
sine(pi/2, 100)
```

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## Warning in factorial(2 * i - 1): value out of range in 'gammafn'

    ## [1] 1

For loop with a matrix

``` r
set.seed(123)
X <- matrix(rnorm(12), nrow = 4, ncol = 3)
X
```

    ##             [,1]       [,2]       [,3]
    ## [1,] -0.56047565  0.1292877 -0.6868529
    ## [2,] -0.23017749  1.7150650 -0.4456620
    ## [3,]  1.55870831  0.4609162  1.2240818
    ## [4,]  0.07050839 -1.2650612  0.3598138

``` r
Y <- matrix(0, nrow = nrow(X), ncol = ncol(X))
for (i in 1 : nrow(X)) {
  for (j in 1 : ncol(X)) {
    if (X[i,j] < 0) {
      Y[i,j] <- X[i,j]^2
    }
    else {
      Y[i,j] <- sqrt(X[i,j])
    }
  }
}

Y
```

    ##            [,1]      [,2]      [,3]
    ## [1,] 0.31413295 0.3595660 0.4717668
    ## [2,] 0.05298168 1.3096049 0.1986146
    ## [3,] 1.24848240 0.6789081 1.1063823
    ## [4,] 0.26553416 1.6003799 0.5998448

Dividing a number by 2 multiple times

``` r
reduce <- function(x) {
  while (x %% 2 == 0) {
    print(x)
    x <- x/2
  }
}

reduce(898128000)
```

    ## [1] 898128000
    ## [1] 449064000
    ## [1] 224532000
    ## [1] 112266000
    ## [1] 56133000
    ## [1] 28066500
    ## [1] 14033250

Average

``` r
xbar <- function (x = 0) {
  n <- length(x)
  sum = 0
  for (i in 1 : n) {
    sum = sum + x[i]
  }
  xbar <- sum / n
  xbar
}
x <- 1 : 100
xbar(x)
```

    ## [1] 50.5

``` r
xbar1 <- function (x = 0) {
  n <- length(x)
  sum = 0
  i = 1
  while (i <= length(x)) {
    sum = sum + x[i]
    i = i + 1
  }
  xbar <- sum / n
  xbar
}
xbar1(x)
```

    ## [1] 50.5

``` r
xbar2 <- function (x = 0) {
  n <- length(x)
  sum <- 0
  i <-  1
  repeat {
    if (i > length(x)) {
      xbar <- sum / n
    break
    }
  sum = sum + x[i]
  i = i + 1
  }
  xbar
}

xbar2(x)
```

    ## [1] 50.5

``` r
stdv <- function (x = 0) {
  n <- length(x)
  xbar <- mean(x)
  sum = 0
  i = 1
  repeat{
    if (i > length(x)){
      stdv = sqrt(sum/n-1)
      break
    }
    sum = sum + (x[i] - xbar)^2
    i = i + 1
  }
  stdv
}

stdv(x)
```

    ## [1] 28.84874

``` r
stdv1 <- function (x = 0) {
  n <- length(x)
  xbar <- mean(x)
  sum = 0
  for (i in 1 : n) {
    sum = sum + (x[i] - xbar)^2
  }
  stdv = sqrt(sum/(n-1))
  stdv
}

stdv1(x)
```

    ## [1] 29.01149

``` r
stdv2 <- function (x = 0) {
  n <- length(x)
  xbar <- mean(x)
  sum = 0
  while (i <= length(x)){
    sum = sum + (x[i] - xbar)^2
    i = i + 1
  }
  stdv = sqrt(sum/(n-1))
  stdv
}

stdv2(x)
```

    ## [1] 27.75547

``` r
x <- 1:50
geombar <- function(x = 0) {
  n <- length(x)
  mul <- 1
  i = 1
  repeat{
    if(i > n){
      mul = mul^(1/n)
      break
    }
    mul = mul * x[i]
    i = i + 1
  }
  mul
}

geombar(x)
```

    ## [1] 19.48325

``` r
x <- 1:50
geombar2 <- function(x = 0){
  n <- length(x)
  mul <- 1
  i = 1
  while(i <= n){
    mul <- mul*x[i]
    i = i + 1
  }
  mul <- mul^(1/n)
  mul
}

geombar2(x)
```

    ## [1] 19.48325

``` r
x <- 1:50
geombar3 <- function(x = 0){
  n <- length(x)
  mul <- 1
  for(i in 1 : n){
    mul <- mul * x[i]
  }
  mul <- mul^(1/n)
  mul
}

geombar3(x)
```

    ## [1] 19.48325
