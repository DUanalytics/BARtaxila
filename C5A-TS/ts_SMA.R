#Moving Averages

#rainfall
(delhi = rnorm(365, mean=50, sd=10))
length(delhi)
(mumbai = rnorm(365, mean=70, sd=15))

library(TTR)
delhi
#daily data
(TS_delhi = ts(data=delhi, start=c(2019), freq=365))
(TS_delhi = ts(data=delhi, start=c(2019,1), end=c(2019,365),freq=365))
TS_delhi
plot(TS_delhi)

#Simple Moving
x= c(1,2,3,4,5,6)
SMA(x,3)

#first 100 days
SMA7 = SMA(TS_delhi[1:100],n=7)  #weekly moving average
plot(SMA7, type='b')

tail(TS_delhi)
forecast::forecast(TS_delhi,h=10)
1/365  #day into decimal
#
?forecast::forecast
#Exp Smoothening
library(forecast)
?WWWusage #users per min connected to internet
head(WWWusage)
WWWusage
WWWusage %>% forecast %>% plot
window(WWWusage, end=60)  #last 60 records
fit <- ets(window(WWWusage, end=60))
fit
fc <- forecast(WWWusage, model=fit)
fc
require(smooth)
require(Mcomp)





#https://cran.r-project.org/web/packages/smooth/vignettes/sma.html
