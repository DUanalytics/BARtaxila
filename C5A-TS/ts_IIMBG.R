#IIMBG

AirPassengers
?AirPassengers
summary(AirPassengers)
cycle(AirPassengers)
AirPassengers
plot(AirPassengers)
decompose(AirPassengers)
plot(decompose(AirPassengers))
monthplot(AirPassengers)

JohnsonJohnson
?JohnsonJohnson
cycle(JohnsonJohnson)
plot(JohnsonJohnson)
plot(decompose(JohnsonJohnson))

(data = trunc(rnorm(366, mean=60, sd=10)))
(yearly = ts(data, start=(1000), freq=1))
yearly
plot(yearly)

(quarterly = ts(data, start=c(2000,2), end=c(2003,3), freq=4))
quarterly
plot(quarterly)

(monthly = ts(data, start=c(2000,3), freq=12))
monthly
plot(monthly)

(daily = ts(data, start=c(2000,5), freq=365))
daily
plot(daily)

#create Monthly times series from Apr 2010 to Sep 2015 with any random data

(data = trunc(rnorm(365,mean = 60,sd =  10)))
monthly = ts(data , start = c(2010,4), end=c(2015,9), freq = 12)
monthly
plot(monthly)
monthplot(monthly)

#library - xts, zoo

tsdata = ts(data = sample(100:150), start=c(2019,1), end=c(2020,4), frequency=12)

plot(daily)
cycle(daily)
monthplot(daily)
tsdata
class(tsdata)
window(tsdata, start=c(2019,2), end=c(2019,5) )
plot(tsdata)

ts(data = sample(100:150), start=c(2019), frequency=4)
plot(ts(data = sample(100:150), start=c(2019,1), end=c(2019,52), frequency=52))
ts(data = sample(100:150), start=c(2019,1), end=c(2019,52), frequency=52)
ts(data = sample(100:150), start=c(2019), frequency=365)


#library(timeSeries)

AirPassengers
?windows
# May 1952 to Sep 1957
s1 <- window(AirPassengers, start = c(1952,5) , end = c(1957 , 9) )
s1
monthplot(s1)
#log(x * y)  : x + y

AirPassengers
library(TTR)
TTR::SMA(AirPassengers, n=3 )
x=c(1,2,3,4,5)
(1+2+3)/3; (2+3+4)/3
AirPassengers[1:5]
mean(AirPassengers[1:3]); mean(AirPassengers[2:4]) ;mean(AirPassengers[3:5])
TTR::SMA(AirPassengers, n=3 )[1:10]
sma.3 = TTR::SMA(AirPassengers, n=3 )
plot(AirPassengers)
plot(sma.3)
sma.15 = TTR::SMA(AirPassengers, n=15 )
plot(sma.15)
dAR <- decompose(AirPassengers)
dAR$trend
plot(AirPassengers - dAR$seasonal)

plot(dAR$trend)
plot(dAR$seasonal)
smooth::sma(AirPassengers, h=3)[1:10]
?SMA
#
ar.stl <- stl(AirPassengers, s.window = 'periodic')
forecast::seasadj(ar.stl)

AirPassengers[1:5]
plot(decompose(AirPassengers))
decompose(AirPassengers, type="mult")


#Moving Average----
tsdata
library(TTR)
SMA3 = SMA(tsdata,3)  #smoothening
SMA3
plot(tsdata)
plot(SMA3)
#(x1+x2+x3)/3  : keep shifting
#library(timeSeries)
#Exponential Smoothening : recent values more weightage
ES = forecast::ets(tsdata)
ES
forecast::forecast(ES,2)  #forecast next 2 months

sales = round(rnorm(100, mean=120, sd=2))
sales
ts1 = ts(data=sales, start=c(2010,1), frequency = 12)
ts1
plot(ts1)
SMA1a = SMA(ts1, n=5)
head(ts1); head(SMA1a)
sum(ts1[1:5])/5
forecast::forecast(SMA1a, 3)

#built in data sets
AirPassengers
?AirPassengers
monthplot(AirPassengers)
forecast::seasonplot(AirPassengers)
plot(AirPassengers)

#Decompose into Components : Random, Seasonsal, Trend
dcAP <- decompose(AirPassengers, type = "multiplicative")
dcAP
plot(dcAP)  #see the components
dcAP$seasonal  #which are high season periods
forecast::seasonplot(AirPassengers)

#multiple sales/ stocks
library(zoo)
library(xts)

#financialdata----
library(quantmod)

#download stock prices
start <- as.Date("2019-10-01") ;end <- as.Date("2019-12-20")
getSymbols("SBIN.NS", src = "yahoo", from = start, to = end)
SBIN.NS
head(SBIN.NS)
tail(SBIN.NS)
plot(SBIN.NS[, "SBIN.NS.Close"], main = "SBIN.NS")
candleChart(SBIN.NS, up.col = "black", dn.col = "red", theme = "white")
?candleChart
#multiple stocks - prices from 
getSymbols(c("ICICIBANK.NS", "TATAMOTORS.NS", "RELIANCE.NS"), src = "yahoo", from = start, to = end)
tail(ICICIBANK.NS)
tail(TATAMOTORS.NS,n=2)
tail(RELIANCE.NS,n=2)
stocks = as.xts(data.frame(SBIN = SBIN.NS[, "SBIN.NS.Close"], ICICI = ICICIBANK.NS[, "ICICIBANK.NS.Close"], TATAMOTORS = TATAMOTORS.NS[, "TATAMOTORS.NS.Close"]))
head(stocks)
plot(as.zoo(stocks), screens = 1, lty = 1:3, xlab = "Date", ylab = "Price")
legend("right", c("SBIN", "ICICI", "TATATMOTORS"), lty = 1:3, cex = 0.5)

#Summary
#Dates
#Time Series- Additive/ Multiplicative, Smoothening (SMA), Forecasting, Plot - seaonsal, monthly
#Stock Prices
