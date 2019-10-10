#ggplot - Time Series

library(ggplot2)
library(ggfortify)


#base
plot(AirPassengers)



## From Timeseries object (ts)
theme_set(theme_classic())

# Plot 
autoplot(AirPassengers) +   labs(title="AirPassengers") +   theme(plot.title = element_text(hjust=0.5))

(dates = Sys.Date())
(dates = Sys.Date() - 1:25)
(scount = sample(30:50, size=25, replace=T))
(gender = sample(c('M','F'), size=25, replace=T))
(attendance = data.frame(dates, scount, gender))

ggplot(attendance, aes(x=dates)) +   geom_line(aes(y=scount), color='red') +  labs(title="Time Series Chart",   subtitle="Student Attendance", y="Count")

ggplot(attendance, aes(x=dates)) +   geom_line(aes(y=scount, color=gender)) +  labs(title="Time Series Chart",   subtitle="Student Attendance", y="Count") + geom_text(aes(label=scount, y=scount)) + geom_vline(xintercept = dates, color='green') + geom_hline(yintercept = c(20,30,40,50), color='blue')

                                               