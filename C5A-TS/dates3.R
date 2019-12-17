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

#some calculations with instants. Note that the units are seconds:
tm2.lub - tm1.lub

tm2.lub > tm1.lub

tm1.lub + 30  #seconds

#An interval is the span of time that occurs between two specified instants.
in.bed <- as.interval(tm1.lub, tm2.lub)
in.bed

#Check whether a certain instant occured with a specified interval:
tm3.lub
tm3.lub %within% in.bed

tm4.lub %within% in.bed

#determine whether two intervals overlap:
daylight <- as.interval(ymd_hm("2013-07-25 06:03"), ymd_hm("2013-07-25 20:23"))
daylight
int_overlaps(in.bed, daylight)

#A duration is a time span not anchored to specific start and end times. It has an exact, fixed length, and is stored internally in seconds.
#create some durations:
  
ten.minutes <- dminutes(10)
ten.minutes

five.days <- ddays(5)
five.days

one.year <- dyears(1)
one.year

as.duration(in.bed)

#arithmatic with durations:
  
tm1.lub - ten.minutes

five.days + dhours(12)

ten.minutes/as.duration(in.bed)

#A period is a time span not anchored to specific start and end times, and measured in units larger than seconds with inexact lengths. create some periods:
  
three.weeks <- weeks(3)
three.weeks

four.hours <- hours(4)
four.hours

#arithmatic with periods:
tm4.lub + three.weeks

sabbatical <- months(6) + days(12)
sabbatical

three.weeks/sabbatical


#The clock has a circular scale, which ends where it begins, so we need to use circular statistics. (For more info on circular statistics see http://en.wikipedia.org/wiki/Mean_of_circular_quantities.)

#Get the package, psych.

require(psych) 

(bed.times = c(tm1.lub, tm2.lub))
mean(bed.times)  #will not work
pysch::circadian.mean(bed.times)

#----
sleep <- data.frame(bed.time = ymd_hms("2013-09-01 23:05:24", "2013-09-02 22:51:09",  "2013-09-04 00:09:16", "2013-09-04 23:43:31", "2013-09-06 00:17:41", "2013-09-06 22:42:27",  "2013-09-08 00:22:27"), rise.time = ymd_hms("2013-09-02 08:03:29", "2013-09-03 07:34:21", "2013-09-04 07:45:06", "2013-09-05 07:07:17", "2013-09-06 08:17:13", "2013-09-07 06:52:11", "2013-09-08 07:15:19"), sleep.time = dhours(c(6.74, 7.92, 7.01, 6.23, 6.34, 7.42, 6.45)))
sleep

sleep$efficiency <- round(sleep$sleep.time/(sleep$rise.time - sleep$bed.time) * 100, 1)
sleep
colMeans(sleep)  # doesn't work
circadian.mean(hour(sleep$bed.time) + minute(sleep$bed.time)/60 + second(sleep$bed.time)/3600)

circadian.mean(hour(sleep$rise.time) + minute(sleep$rise.time)/60 + second(sleep$rise.time)/3600)
mean(sleep$sleep.time)/3600

par(mar = c(5, 4, 4, 4))
plot(round_date(sleep$rise.time, "day"), sleep$efficiency, type = "o", col = "blue", xlab = "Morning", ylab = NA)
par(new = TRUE)
plot(round_date(sleep$rise.time, "day"), sleep$sleep.time/3600, type = "o",  col = "red", axes = FALSE, ylab = NA, xlab = NA)
axis(side = 4)
mtext(side = 4, line = 2.5, col = "red", "Sleep duration")
mtext(side = 2, line = 2.5, col = "blue", "Sleep efficiency")
