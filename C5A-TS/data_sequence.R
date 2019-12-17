#create Dates

#Create Dates by Merging Data

#Sometimes your date data are collected in separate elements. To convert these separate data into one date object incorporate the ISOdate() function:
  
yr <- c("2012", "2013", "2014", "2015")
mo <- c("1", "5", "7", "2")
day <- c("02", "22", "15", "28")

# ISOdate converts to a POSIXct object
ISOdate(year = yr, month = mo, day = day)

# truncate the unused time data by converting with as.Date
as.Date(ISOdate(year = yr, month = mo, day = day))

#ISODate() also has arguments to accept data for hours, minutes, seconds, and time-zone if you need to merge all these separate components.



#Creating date sequences
#To create a sequence of dates we can leverage the seq() function. As with numeric vectors, you have to specify at least three of the four arguments (from, to, by, and length.out).

seq(as.Date("2017-10-15"), as.Date("2022-1-15"), by = "years")
seq(as.Date("2017-10-15"), as.Date("2022-1-15"), by = "quarter")
seq(as.Date("2017-10-15"), as.Date("2022-1-15"), by = "2 days")

#Using the lubridate package is very similar. The only difference is lubridate changes the way you specify the first two arguments in the seq() function.
library(lubridate)
seq(ymd("2010-1-1"), ymd("2015-1-1"), by = "years")
seq(ymd("2015/1/1"), ymd("2015/12/30"), by = "quarter")
seq(ymd('2015-09-15'), ymd('2015-09-30'), by = "2 days")


#------
#Creating sequences with time is very similar; however, we need to make sure our date object is POSIXct rather than just a Date object (as produced by as.Date)
seq(as.POSIXct("2015-1-1 0:00"), as.POSIXct("2015-1-1 12:00"), by = "hour")
# with lubridate
seq(ymd_hm("2015-1-1 0:00"), ymd_hm("2015-1-1 12:00"), by = "hour")


#tz
OlsonNames()
