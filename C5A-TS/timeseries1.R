#Time Series 

#The ts() function will convert a numeric vector into an R time series object. The format is ts(vector, start=, end=, frequency=) where start and end are the times of the first and last observation and frequency is the number of observations per unit time (1=annual, 4=quartly, 12=monthly, etc.).


# save a numeric vector containing 72 monthly observations
(sales = round(rnorm(n=72, mean=100, sd=10)))
plot(sales)
plot(sales, type='b')

# from Jan 2010 to Dec 2019 as a time series object
myts <- ts(sales, start=c(2014, 1), end=c(2019, 12), frequency=12)
myts
plot(myts)

# subset the time series (June 2014 to December 2014)
myts2 <- window(myts, start=c(2018, 6), end=c(2019, 12))
myts2

# plot series
plot(myts2)



#Seasonal Decomposition
#A time series with additive trend, seasonal, and irregular components can be decomposed using the stl() function. Note that a series with multiplicative effects can often by transformed into series with additive effects through a log transformation (i.e., newts <- log(myts)).

# Seasonal decomposition
fit <- stl(myts, s.window="period")
plot(fit)

# additional plots
monthplot(myts)

library(forecast)
seasonplot(myts)



#-------------------
#Exponential Models
#Both the HoltWinters() function in the base installation, and the ets() function in the forecast package, can be used to fit exponential models.

# simple exponential - models level
fit <- HoltWinters(myts, beta=FALSE, gamma=FALSE)

# double exponential - models level and trend
fit1 <- HoltWinters(myts, gamma=FALSE)
fit1

# triple exponential - models level, trend, and seasonal components
fit2 <- HoltWinters(myts)

# predictive accuracy
#forecast::accuracy(fit2)

# predict next three future values
forecast::forecast(fit1, 3)
plot(forecast::forecast(fit1, 3))
plot(forecast::forecast(fit2, 3))



#Automated Forecasting
#The forecast package provides functions for the automatic selection of exponential and ARIMA models. The ets() function supports both additive and multiplicative models. The auto.arima() function can handle both seasonal and nonseasonal ARIMA models. Models are chosen to maximize one of several fit criteria.

library(forecast)
# Automated forecasting using an exponential model
fit <- ets(myts)
plot(fit)

# Automated forecasting using an ARIMA model
fit <- auto.arima(myts)
fit
forecast(fit,3)


#https://www.statmethods.net/advstats/timeseries.html
#https://www.analyticsvidhya.com/blog/2015/12/complete-tutorial-time-series-modeling/

