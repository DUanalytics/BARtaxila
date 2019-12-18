#TS - Ggplots

# Libraries
library(ggplot2)
library(dplyr)

# Dummy data
data <- data.frame(  day = as.Date("2019-01-01") + 0:364, value = runif(365) + seq(-140, 224)^2 / 10000 )
data
range(data$day)
# Most basic bubble plot
p <- ggplot(data, aes(x=day, y=value)) +  geom_line() +   xlab("")
p

#As soon as the time variable is recognized as a date, you can use the scale_x_date() function to choose the format displayed on the X axis.
str(data)

p+scale_x_date(date_labels = "%b")
p+scale_x_date(date_labels = "%Y %b %d")
p+scale_x_date(date_labels = "%W")
p+scale_x_date(date_labels = "%m-%Y")


#Breaks-------
#It also possible to control the amount of break and minor breaks to display with date_breaks and date_minor_breaks.

p + scale_x_date(date_breaks = "1 week", date_labels = "%W")
p + scale_x_date(date_minor_breaks = "2 day")

#angle
p + theme(axis.text.x=element_text(angle=60, hjust=1)) 


#limits
#Use the limit option of the scale_x_date() function to select a time frame in the data:
range(data$day)
p + scale_x_date(limit=c(as.Date("2019-10-01"),as.Date("2019-12-22")))


head(data)
#annotate
g1 <- ggplot(data=data, aes(x=day, y=value)) +   geom_line(color="#69b3a2") 
data[c(1,100,200),]
head(data)

g1 + annotate(geom="text", x=as.Date("2019-07-19"), y=0.67,  label=paste("Begin of Couse Dates", 0.67)) +  annotate(geom="point", x=as.Date("2019-07-19"), y=.62, size=10, shape=21, fill="transparent") +  geom_hline(yintercept=.65, color="orange", size=.5)



#
library(ggfortify)

?ggfortify
forecast::ggmonthplot(nottem)
