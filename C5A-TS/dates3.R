#Lubridate
#Manipulating times and dates
#lubridate -This package is a wrapper for POSIXct with more intuitive syntax.

library(lubridate) 

#create a time:
tm1.lub <- ymd_hms("2019-12-22 13:25:35")
tm1.lub

tm2.lub <- mdy_hm("12/23/19 09:30")
tm2.lub

tm3.lub <- ydm_hm("2019-23-12 1:00pm")
tm3.lub

tm4.lub <- dmy("31122019")
tm4.lub

#some manipulations: extract or reassign componants:
year(tm1.lub)

week(tm1.lub)

wday(tm1.lub, label = TRUE)

hour(tm1.lub)

tz(tm1.lub)
## [1] "UTC" - Coordinated Universal Time (or UTC) is the primary time standard by which the world regulates clocks and time. It is within about 1 second of mean solar time at 0° longitude, and is not adjusted for daylight saving time. In some countries
tm2.lub
second(tm2.lub) <- 7  #change second to
tm2.lub

#converting to decimal hours can facilitate some types of calculations:
  
tm1.dechr <- hour(tm1.lub) + minute(tm1.lub)/60 + second(tm1.lub)/3600
tm1.dechr  #hour

#Lubridate distinguishes between four types of objects: instants, intervals, durations, and periods. An instant is a specific moment in time. Intervals, durations, and periods are all ways of recording time spans.

#Dates and times parsed in lubridate are instants:
is.instant(tm1.lub)

#round an instant:
round_date(tm1.lub, "minute")

round_date(tm1.lub, "day")

#get the current time or date as an instant:
now()

today()

#Note that lubridate uses UTC time zones as default.
#see an instant in a different time zone:
with_tz(tm1.lub, "America/Los_Angeles")

#change the time zone of an instant (keeping the same clock time):
force_tz(tm1.lub, "America/Los_Angeles")
## [1] "2013-07-24 23:55:26 PDT"
some calculations with instants. Note that the units are seconds:
  
  tm2.lub - tm1.lub
## Time difference of 8.611 hours
tm2.lub > tm1.lub
## [1] TRUE
tm1.lub + 30
## [1] "2013-07-24 23:55:56 UTC"
An interval is the span of time that occurs between two specified instants.

in.bed <- as.interval(tm1.lub, tm2.lub)
in.bed
## [1] 2013-07-24 23:55:26 UTC--2013-07-25 08:32:07 UTC
Check whether a certain instant occured with a specified interval:
  
  tm3.lub %within% in.bed
## [1] TRUE
tm4.lub %within% in.bed
## [1] FALSE
determine whether two intervals overlap:
  
  daylight <- as.interval(ymd_hm("2013-07-25 06:03"), ymd_hm("2013-07-25 20:23"))
daylight
## [1] 2013-07-25 06:03:00 UTC--2013-07-25 20:23:00 UTC
int_overlaps(in.bed, daylight)
## [1] TRUE
A duration is a time span not anchored to specific start and end times. It has an exact, fixed length, and is stored internally in seconds.

create some durations:
  
  ten.minutes <- dminutes(10)
ten.minutes
## [1] "600s (~10 minutes)"
five.days <- ddays(5)
five.days
## [1] "432000s (~5 days)"
one.year <- dyears(1)
one.year
## [1] "31536000s (~365 days)"
as.duration(in.bed)
## [1] "31001s (~8.61 hours)"
arithmatic with durations:
  
  tm1.lub - ten.minutes
## [1] "2013-07-24 23:45:26 UTC"
five.days + dhours(12)
## [1] "475200s (~5.5 days)"
ten.minutes/as.duration(in.bed)
## [1] 0.01935
A period is a time span not anchored to specific start and end times, and measured in units larger than seconds with inexact lengths. create some periods:
  
  three.weeks <- weeks(3)
three.weeks
## [1] "21d 0H 0M 0S"
four.hours <- hours(4)
four.hours
## [1] "4H 0M 0S"
arithmatic with periods:
  
  tm4.lub + three.weeks
## [1] "2013-08-16 UTC"
sabbatical <- months(6) + days(12)
sabbatical
## [1] "6m 12d 0H 0M 0S"
three.weeks/sabbatical