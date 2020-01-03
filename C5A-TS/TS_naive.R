#Time Series - Forecasting Naive
#https://en.wikipedia.org/wiki/Forecasting
#https://stepupanalytics.com/step-by-step-guide-to-time-series-analysis-in-r/
#https://optimizerkapil.files.wordpress.com/2014/07/untitled.png
#It is the simplest form of model. This approach says that the forecast for any period equals the previous period’s actual value. This model does not require large number of data points as one last period data is needed for forecasting. It can take seasonality, trend or both into account.
#This model gives full weight to the last period original value. Hence it is not able to capture the features of data series. It can’t be applied on non stationary data series
#once you have checked for the stationarity, we can go onto the next stage of forecasting future observations. There are many forecasting methods but in this blog, we will be discussing the following:
  
#The average method
#Naïve method
#Seasonal naïve method
#ARIMA
#SARIMA

#Naïve Method: As the name suggests, under this method the forecasted values are just equal to the last observation.

library(tseries)
library(forecast)
library(fpp)
fpp::ausbeer
data(ausbeer)
cycle(ausbeer)
ausbeer
window(ausbeer,start=1992,end=2005)
window(ausbeer,start=1992,end=c(2005,4))
beer2 = window(ausbeer,start=1992,end=2006-.1)  #upto 2005
beer2
plot(beer2) #seasonal component present
library(ggfortify)
forecast::autoplot(decompose(beer2))

#Before we proceed to the analysis of the time series data, we need to make a simplifying assumption in order to maintain the regularity of the time series
#assumption is the stationarity assumption. This simply means that the mean and variance of the time series are constant over time i.e they are invariant over time. Also, the covariance between two time periods depends on the gap between the two periods and not the time at which they are computed.
#In order to verify the stationarity of a specific timeseries we use the widely known Augmented-Dickey otherwise known as the Dickey-Fuller test.
adf.test(beer2)
#null hypothesis under this test is that the time series under study in not stationary and we accept Ho if the p-value>0.05.

#we reject the null hypothesis and say that the time series considered is stationary. In case it wasn’t stationary we could’ve simply used the ndiffs() function in R to get the number of times, the series should be differenced in order to convert it into a stationary time series. But for now, we won’t discuss deeper about differencing.
# --- Stationery TS - beer2 -----

#Average Method: Under this method, the forecasted future values are just an average of the historical values. It can be easily executed in R using the following commands:

?meanf  #mean forecast
beerfit1 = forecastmeanf(beer2, h=5) #where in h=5 shows that the forecast is made for 5 years.
plot(beerfit1)
#blue line represents the forecasted values and the dark and light grey areas represent the 95% and 80% confidence intervals.

#Naïve Method: As the name suggests, under this method the forecasted values are just equal to the last observation.

beerfit2 = naive(beer2, h=5)
plot(beerfit2)

#Seasonal Naïve Method: We know that there is some seasonality in our data, when such kind of time series are available the Seasonal Naïve Method provides better forecasting accuracy than the simple Naïve method. Naïve methods are very useful in economic and financial data.

beerfit3 = snaive(beer2, h=5)
plot(beerfit3)


#AutoArima -----
#ARIMA(1,1,1) (1,1,1)[4] denote a quarterly data with non-seasonal and seasonal differencing by 1 and AR order 1 and MA order 1 for both seasonal and non-seasonal parts.
#this function shouldn’t be applied blindly to any time series. Another advantage of using this function is that, it automatically differences the time series to make it stationary.
#there is presence of seasonality in the data and that the given data is a quarterly data. The drift term here simply means the intercept term or the constant term in the model. The next step to forecast or predict the future values.

beerfit4 = auto.arima(beer2,stepwise = F,approximation = F,trace = T)
beerfit4

fore <- forecast(beerfit4,h=5)
plot(fore)

#The last step in this analysis is to measure the forecasting accuracy of the models. This can be done by the accuracy() function in the forecast package. It gives us a list of different accuracy measures that can be used to determine the best model fit. #compare the forecasted value in 2007 with the actual value(beer3)

beer3 = window(ausbeer, start=2007)
beer3  #period after model
accuracy(beerfit1, beer3)
accuracy(beerfit2, beer3)
accuracy(beerfit3, beer3)
accuracy(fore,beer3)

#lowest RMSE value has been obtained for the Seasonal ARIMA model i.e 12.161. Hence, it is the best fit model.
#https://campus.datacamp.com/courses/forecasting-using-r/benchmark-methods-and-forecast-accuracy?ex=2
