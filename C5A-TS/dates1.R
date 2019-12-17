# Dates in R

#Date Classess

#Date- This is the class to use if you have only dates, but no times, in your data.
Sys.Date()  #todays Date

dt1 <- as.Date("2019-12-22")
dt1

#different format of date : Course start
dt2 <- as.Date("10/15/2019", format = "%m/%d/%Y")
dt2

dt3 <- as.Date("December 12, 2019", format = "%B %d, %Y")
dt3

#see list of format symbols:
`?`(strptime)

#calculations with dates:

#find the difference between dates:
dt1 - dt2

## in weeks
difftime(dt1, dt2, units = "weeks")

#Add or subtract days:
dt1 + 10

dt1 - 10

#create a vector of dates and find the intervals between them:
three.dates <- as.Date(c("2019-10-15", "2019-12-22", "2020-01-15"))
three.dates

diff(three.dates)
diff(three.dates[c(1,3)])

#------
dt2
#create a sequence of dates:
six.weeks <- seq(dt2, length = 6, by = "week")
six.weeks

six.weeks <- seq(dt2, length = 6, by = 14) #biweekly
six.weeks

six.weeks <- seq(dt2, length = 6, by = "2 weeks")
six.weeks

three.months <- seq(dt2, length = 3, by = "month")
three.months

#see the internal integer representation
unclass(dt2)
dt2 - as.Date("1970-01-01")
## Time difference of 15543 days from Reference Date


#Time----------------------
#POSIXct:If you have times in your data, this is usually the best class to use.

#create some POSIXct objects:
tm1 <- as.POSIXct("2019-12-22 10:10:00")
tm1

tm2 <- as.POSIXct("221219 11:30:00", format = "%d%m%y %H:%M:%S")
tm2

#specify the time zone:
tm3 <- as.POSIXct("2019-12-22 10:00:00", tz = "GMT")
tm3

#some calculations with times :compare times:
tm2 ; tm1

tm2 > tm1

#Add or subtract seconds:
tm1
tm1 + 30  #seconds
tm1 - 30

#find the difference between times:
tm2 - tm1  #hours

tm3 - tm1  #diff in time zones

#Get the current time (in POSIXct by default):
Sys.time()  #now

#see the internal integer representation:
unclass(tm1)
difftime(tm1, as.POSIXct("2019-12-22 06:05:00"), units = "mins")
difftime(tm1, as.POSIXct("2019-12-22 06:05:00"), units = "hours")
#auto, secs, mins, hours, days, weeks

#C3: POSIXlt-----
#This class enables easy extraction of specific components of a time. (“ct” stand for calender time and “lt” stands for local time. “lt” also helps one remember that POXIXlt objects are lists.)

#create a time:
tm1.lt <- as.POSIXlt("2019-12-22 13:30:10")
tm1.lt

unclass(tm1.lt)  #see the parts
unlist(tm1.lt)  #horizontally

#extract componants of a time object:
tm1.lt$sec
tm1.lt$wday  #start on Sat

#truncate or round off the time:
trunc(tm1.lt, "days")  #remove time

trunc(tm1.lt, "mins") #approx minutes, round seconds


#C4:chron----
#This class is a good option when you don’t need to deal with timezones. It requires the package chron.

require(chron)

#create some times:
tm1.c <- as.chron("2019-12-23 13:25:55")
tm1.c
tm2.c <- as.chron("12/23/19 17:50:00", "%m/%d/%y %H:%M:%S")
tm2.c
#extract just the date:
dates(tm1.c)

#compare times:
tm2.c > tm1.c
## [1] TRUE
#add days:
tm1.c + 10

#calculate the differene between times:
tm2.c - tm1.c

difftime(tm2.c, tm1.c, units = "hours")

#Detach the chron package as it will interfere with lubridate later in this script.
detach("package:chron", unload = TRUE)


#Summary
# When you just have dates, use Date.
# When you have times, POSIXct is usually the best,
# but POSIXlt enables easy extraction of specific components
# and chron is simplest when you don’t need to deal with timezones and daylight savings time.