#ARima

#real-time series to fit the optimal model from it. For that purpose, you'll use the forecast package. The function auto.arima fits and selects the optimal model from the data and forecast function allows the prediction of h periods ahead.
#Autoregressive Integrated Moving Average Models are time series defined by the equation:  SARIMA(p,d,q)(P,D,Q) process
#contains p autoregressive terms and q moving average terms is said to be of order (p,q)
#Differencing is the most common method for making a time series data stationary. This is a special type of filtering, particularly important in removing a trend. For seasonal data, first order differencing data is usually sufficient to attain stationarity in a mean. (d term)

# R packages to be used
library(forecast)
library(TSA)


# Data from TSA package
data("co2")
data("boardings")

# fitting
fit1 <- auto.arima(co2)
fit1
plot(fc1 <- forecast(fit1, h = 15))

data("boardings")
fit2 <- auto.arima(boardings[,"log.price"])

# forecasting
plot(fc2 <- forecast(fit2, h = 15))

