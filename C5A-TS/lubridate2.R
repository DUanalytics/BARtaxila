#Lubridate 2


library(lubridate)

x <- c("2015-07-01", "2015-08-01", "2015-09-01")
year(x)

# default is numerical value
month(x)
## [1] 7 8 9

# show abbreviated name
month(x, label = TRUE)
## [1] Jul Aug Sep
## 12 Levels: Jan < Feb < Mar < Apr < May < Jun < Jul < Aug < Sep < ... < Dec

# show unabbreviated name
month(x, label = TRUE, abbr = FALSE)


wday(x, label = TRUE, abbr = FALSE)

# convert to date format
x <- ymd(x)
x

# change the days for the dates
mday(x)
mday(x) <- c(3, 10, 22)
x

# can also use 'update()' function
#update(x, year = c(2013, 2014, 2015), month = 9)

# can also add/subtract units
#x + years(1) - days(c(2, 9, 21))

