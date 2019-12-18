# Case - Dates

library(lubridate)
library(hflights)
library(dplyr)

str(hflights)
head(hflights)
?hflights
head(lakers)
str(lakers$date)

#Adding Day, Month and Year from different columns together

#When using dplyr package you can add separated date related columns together to make a date format that is more useful. I will demonstrate this with the hflights dataset using the dplyr mutate function:

#mutate(dataset, Date = paste(Year, Month, Day, sep = “-”))
#new DF
Dated_hflights <- mutate(hflights,Date = paste(Year, Month, DayofMonth, sep = "-"))
str(Dated_hflights$Date)


#Using lubridate to parse the date string
#Lubridate’s selected function will then parse the date string into R as POSIXct date-time objects.
#Using: ymd(lakers$date) will output:
lakers$date[1:10]
ymd(lakers$date[1:10])
ymd(Dated_hflights$Date[1:10])



#http://rstudio-pubs-static.s3.amazonaws.com/268221_9a8a8794a0384c8e9acf9020869adbae.html