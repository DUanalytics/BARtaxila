#zoo
#https://cran.r-project.org/web/packages/zoo/vignettes/zoo-quickref.pdf

library(zoo)
## simple creation and plotting
x.Date <- as.Date("2003-02-01") + c(1, 3, 7, 9, 14) - 1
x.Date
x <- zoo(rnorm(5), x.Date)
x
plot(x)
time(x)

## subsetting with numeric indexes
x[c(2, 4)]
## subsetting with index class
x[as.Date("2003-02-01") + c(2, 8)]

## different classes of indexes/times can be used, e.g. numeric vector
x <- zoo(rnorm(5), c(1, 3, 7, 9, 14))
## subsetting with numeric indexes then uses observation numbers
x[c(2, 4)]
## subsetting with index class can be enforced by I()
x[I(c(3, 9))]

## visualization
plot(x)
## or POSIXct
y.POSIXct <- ISOdatetime(2003, 02, c(1, 3, 7, 9, 14), 0, 0, 0)
y <- zoo(rnorm(5), y.POSIXct)
plot(y)

## create a constant series
z <- zoo(1, seq(4)[-2])

## create a 0-dimensional zoo series
z0 <- zoo(, 1:4)
z0
## create a 2-dimensional zoo series
z2 <- zoo(matrix(1:12, 4, 3), as.Date("2003-01-01") + 0:3)
z2
## create a factor zoo object
fz <- zoo(gl(2,5), as.Date("2004-01-01") + 0:9)
fz
## create a zoo series with 0 columns
z20 <- zoo(matrix(nrow = 4, ncol = 0), 1:4)

## arithmetic on zoo objects intersects them first
x1 <- zoo(1:5, 1:5)
x2 <- zoo(2:6, 2:6)
10 * x1 + x2

## $ extractor for multivariate zoo series with column names
z <- zoo(cbind(foo = rnorm(5), bar = rnorm(5)))
z$foo
z$xyz <- zoo(rnorm(3), 2:4)
z

## add comments to a zoo object
comment(x1) <- c("This is a very simple example of a zoo object.",                 "It can be recreated using this R code: example(zoo)")
## comments are not output by default but are still there
x1
comment(x1)

# ifelse does not work with zoo but this works
# to create a zoo object which equals x1 at
# time i if x1[i] > x1[i-1] and 0 otherwise
(diff(x1) > 0) * x1

## zoo series with duplicated indexes
z3 <- zoo(1:8, c(1, 2, 2, 2, 3, 4, 5, 5))
plot(z3)
## remove duplicated indexes by averaging
lines(aggregate(z3, index(z3), mean), col = 2)
## or by using the last observation
lines(aggregate(z3, index(z3), tail, 1), col = 4)

## x1[x1 > 3] is not officially supported since
## x1 > 3 is of class "zoo", not "logical".
## Use one of these instead:
x1[which(x1 > 3)]
x1[coredata(x1 > 3)]
x1[as.logical(x1 > 3)]
subset(x1, x1 > 3)

## any class supporting the methods discussed can be used
## as an index class. Here are examples using complex numbers
## and letters as the time class.

z4 <- zoo(11:15, complex(real = c(1, 3, 4, 5, 6), imag = c(0, 1, 0, 0, 1)))
merge(z4, lag(z4))

z5 <- zoo(11:15, letters[1:5])
merge(z5, lag(z5))

# index values relative to 2001Q1
zz <- zooreg(cbind(a = 1:10, b = 11:20), start = as.yearqtr(2000), freq = 4)
zz[] <- mapply("/", as.data.frame(zz), coredata(zz[as.yearqtr("2001Q1")]))


## even though time index must be unique zoo (and read.zoo)
## will both allow creation of such illegal objects with
## a warning (rather than ana error) to give the user a 
## chance to fix them up.  Extracting and replacing times
## and aggregate.zoo will still work.
# }
# NOT RUN {
# this gives a warning
# and then creates an illegal zoo object
z6 <- zoo(11:15, c(1, 1, 2, 2, 5))
z6

# fix it up by averaging duplicates
aggregate(z6, identity, mean)

# or, fix it up by taking last in each set of duplicates
aggregate(z6, identity, tail, 1)

# fix it up via interpolation of duplicate times
time(z6) <- na.approx(ifelse(duplicated(time(z6)), NA, time(z6)), na.rm = FALSE)
# if there is a run of equal times at end they
# wind up as NAs and we cannot have NA times
z6 <- z6[!is.na(time(z6))]
z6

x1. <- x1 <- zoo (matrix (1:12, nrow = 3), as.Date("2008-08-01") + 0:2)
colnames (x1) <- c ("A", "B", "C", "D")
x2 <- zoo (matrix (1:12, nrow = 3), as.Date("2008-08-01") + 1:3)
colnames (x2) <- c ("B", "C", "D", "E")

both.dates = as.Date (intersect (index (t1), index (t2)))
both.cols = intersect (colnames (t1), colnames (t2))

x1[both.dates, both.cols]
## there is "[.zoo" but no "[<-.zoo" however four of the following
## five examples work

## wrong
## x1[both.dates, both.cols] <- x2[both.dates, both.cols]

# 4 correct alternatives
# #1
window(x1, both.dates)[, both.cols] <- x2[both.dates, both.cols]

# #2. restore x1 and show a different way
x1 <- x1.
window(x1, both.dates)[, both.cols] <- window(x2, both.dates)[, both.cols]

# #3. restore x1 and show a different way
x1 <- x1.
x1[time(x1) <!-- %in% both.dates, both.cols] <- x2[both.dates, both.cols] -->
  
  # #4. restore x1 and show a different way
  x1 <- x1.
x1[time(x1) <!-- %in% both.dates, both.cols] <- x2[time(t2) %in% both.dates, both.cols] -->
  
  # }
  # NOT RUN {
  # }