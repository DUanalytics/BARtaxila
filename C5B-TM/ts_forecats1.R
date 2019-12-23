#Time series

dataLink ="https://docs.google.com/spreadsheets/d/1Lt07TTh5jzbnDMgKYoQ0XLAIa-nZyNFep_Hm-owHJtU/edit#gid=945318993"
library(gsheet)

Amtrak.data = as.data.frame(gsheet2tbl(dataLink))
head(Amtrak.data)

library(zoo)
ridership.ts <- ts(Amtrak.data$Ridership, start=c(1991, 1), end=c(2004,3), freq=12)
ridership.ts

library(forecast)
#linear trend
ridership.lm <- tslm(ridership.ts ~ trend)
plot(ridership.ts, xlab='Time', ylab='Ridership', ylim=c(1300,2300), bty='l')
lines(ridership.lm$fitted.values, lwd=2)
train.ts = window(ridership.ts, end=c(2001,1))
test.ts = window(ridership.ts, start=c(2001,2))
train.ts ; test.ts

#train and test set
train.lm <- tslm(train.ts ~ trend)
train.lm.pred <- forecast(train.lm, level=0)
train.lm.pred
summary(train.lm.pred)


ma.centered <- ma(ridership.ts, order=12)
