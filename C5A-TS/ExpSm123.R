
#contains total annual rainfall in inches for London, from 1813-1912 (original data from Hipel and McLeod, 1994). We can read the data into R and plot it by
rain <- scan("http://robjhyndman.com/tsdldata/hurst/precip1.dat", skip=1)
rain
rainseries <- ts(rain,start=c(1813))
plot.ts(rainseries)
abline(h=25)

rainseriesforecasts <- HoltWinters(rainseries, beta=FALSE, gamma=FALSE)
rainseriesforecasts
rainseriesforecasts$fitted
plot(rainseriesforecasts)
rainseriesforecasts$SSE
library(forecast)
rainseriesforecasts2 <- forecast(rainseriesforecasts, h=5)
rainseriesforecasts2
plot(rainseriesforecasts2)


#ES - I + T
skirts <- scan("http://robjhyndman.com/tsdldata/roberts/skirts.dat",skip=5)
skirtsseries <- ts(skirts,start=c(1866))
plot.ts(skirtsseries)
skirtsseriesforecasts <- HoltWinters(skirtsseries, gamma=FALSE)
skirtsseriesforecasts
plot(skirtsseriesforecasts)
skirtsseriesforecasts2 <- forecast(skirtsseriesforecasts, h=19)
plot(skirtsseriesforecasts2)


#ES = I + T + S
#time series that can be described using an additive model with increasing or decreasing trend and seasonality, you can use Holt-Winters exponential smoothing to make short-term forecasts.

souvenir <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
souvenirtimeseries <- ts(souvenir, frequency=12, start=c(1987,1))
souvenirtimeseries
plot(souvenirtimeseries)
logsouvenirtimeseries <- log(souvenirtimeseries)
souvenirtimeseriesforecasts <- HoltWinters(logsouvenirtimeseries)
souvenirtimeseriesforecasts
plot(souvenirtimeseriesforecasts)
souvenirtimeseriesforecasts2 <- forecast(souvenirtimeseriesforecasts, h=48)
plot(souvenirtimeseriesforecasts2)



#auto arima
WWWusage
?WWWusage
plot(WWWusage)
dim(WWWusage)
plot(decompose(WWWusage))
decompose(WWWusage)
fit <- auto.arima(WWWusage)
fit
plot(forecast(fit,h=20))
fit <- auto.arima(AirPassengers)
fit
plot(forecast(fit,h=20))



#stock prices
#financialdata----
library(quantmod)

#download stock prices
start <- as.Date("2019-10-01") ;end <- as.Date("2020-02-15")
getSymbols("SBIN.NS", src = "yahoo", from = start, to = end)
SBIN.NS
names(SBIN.NS)
head(SBIN.NS)
tail(SBIN.NS)
plot(SBIN.NS[, "SBIN.NS.Close"], main = "SBIN.NS")
candleChart(SBIN.NS, up.col = "green", dn.col = "red", theme = "white")
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
rowSums(is.na(stocks))
stocks[1:20,]
