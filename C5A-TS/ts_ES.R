#Exponential Smoothening in R

#https://johannesmehlem.com/blog/exponential-smoothing-time-series-forecasting-r/
#Exponential smoothing is one of the most popular time series forecasting techniques. It uses historical data with its inherent characteristics as input for the forecasting model, which means that time series forecasting techniques like this are generally most suitable and accurate if:
# sufficient historical data is available,
# the forecasted metric is relatively stable and does not underly extreme fluctuations,
#the forecasting horizon is short-term such as the next quarter or potentially six months.
#Data------
kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat",skip=3)
kings
tskings <- ts(kings)

#MV----
SMA3 = SMA(tskings,n=3)
SMA3
plot(SMA3)
# estimate the trend component of this time series by smoothing using a simple moving average. To smooth the time series using a simple moving average of order 3

#simple ES------
#Simple exponential smoothing assumes that the time series data has only a level and some error (or remainder) but no trend or seasonality. 
#The smoothing parameter α determines the distribution of weights of past observations and with that how heavily a given time period is factored into the forecasted value. If the smoothing parameter is close to 1, recent observations carry more weight and if the smoothing parameter is closer to 0, weights of older and recent observations are more balanced. For example, in the case of α = 0.5, the weight halves with every next older observation: 0.5, 0.25, 0.125, 0.0625, etc
#The smoothing parameter α determines the distribution of weights of past observations and with that how heavily a given time period is factored into the forecasted value. If the smoothing parameter is close to 1, recent observations carry more weight and if the smoothing parameter is closer to 0, weights of older and recent observations are more balanced. For example, in the case of α = 0.5, the weight halves with every next older observation: 0.5, 0.25, 0.125, 0.0625, etc



library(forecast)
fit_ses = ses(tskings)
summary(fit_ses)
plot(fit_ses)

#instead of the ses(Organic_Traffic) function, you can also use ets(Organic_Traffic, model = "ANN") from the forecast package
fit_ets = forecast::ets(tskings)
summary(fit_ets)


rain <- scan("http://robjhyndman.com/tsdldata/hurst/precip1.dat",skip=1)
#Read 100 items
rainseries <- ts(rain,start=c(1813))
plot.ts(rainseries)
#see from the plot that there is roughly constant level (the mean stays constant at about 25 inches). The random fluctuations in the time series seem to be roughly constant in size over time, so it is probably appropriate to describe the data using an additive model. Thus, we can make forecasts using simple exponential smoothing.

rainseriesforecasts <- HoltWinters(rainseries, beta=FALSE, gamma=FALSE)
rainseriesforecasts
#a=0.02 :output of HoltWinters() tells us that the estimated value of the alpha parameter is about 0.024. This is very close to zero, telling us that the forecasts are based on both recent and less recent observations (although somewhat more weight is placed on recent observations).
#forecasts made by HoltWinters() are stored in a named element of this list variable called “fitted”, so we can get their values by typing:
rainseriesforecasts$fitted
plot(rainseriesforecasts)  #original series
#The plot shows the original time series in black, and the forecasts as a red line. The time series of forecasts is much smoother than the time series of the original data here.

#measure of the accuracy of the forecasts, we can calculate the sum of squared errors for the in-sample forecast errors, that is, the forecast errors for the time period covered by our original time series. The sum-of-squared-errors is stored in a named element of the list variable “rainseriesforecasts” called “SSE”, so we can get its value by typing:
rainseriesforecasts$SSE

#It is common in simple exponential smoothing to use the first value in the time series as the initial value for the level. For example, in the time series for rainfall in London, the first value is 23.56 (inches) for rainfall in 1813. You can specify the initial value for the level in the HoltWinters() function by using the “l.start” parameter. For example, to make forecasts with the initial value of the level set to 23.56, we type:
HoltWinters(rainseries, beta=FALSE, gamma=FALSE, l.start=23.56)

#As explained above, by default HoltWinters() just makes forecasts for the time period covered by the original data, which is 1813-1912 for the rainfall time series. We can make forecasts for further time points by using the “forecast.HoltWinters()” function in the R “forecast” package. To use the forecast.HoltWinters() function,
rainseriesforecasts2 <- forecast(rainseriesforecasts, h=8)
rainseriesforecasts2
#orecast for a year, a 80% prediction interval for the forecast, and a 95% prediction interval for the forecast. For example, the forecasted rainfall for 1920 is about 24.68 inches, with a 95% prediction interval of (16.24, 33.11).
plot(rainseriesforecasts2)
#Here the forecasts for 1913-1920 are plotted as a blue line, the 80% prediction interval as an orange shaded area, and the 95% prediction interval as a gray shaded area.
#forecast errors’ are calculated as the observed values minus predicted values, for each time point. We can only calculate the forecast errors for the time period covered by our original time series, which is 1813-1912 for the rainfall data. As mentioned above, one measure of the accuracy of the predictive model is the sum-of-squared-errors (SSE) for the in-sample forecast errors.
rainseriesforecasts2$residuals

#If the predictive model cannot be improved upon, there should be no correlations between forecast errors for successive predictions. In other words, if there are correlations between forecast errors for successive predictions, it is likely that the simple exponential smoothing forecasts could be improved upon by another forecasting technique.

#read more from online site

#Holt exponential smoothing---
#Holt exponential smoothing is a time series forecasting approach that fits time series data with an overall level as well as a trend. Additionally, to simple exponential smoothing, which uses smoothing parameter α only there is also a β smoothing parameter for the exponential decay of the modeled trend component. This β smoothing parameter ranges between 0 and 1, with higher values indicating more weight to recent observations. A β value of 0.5 means that the most recent observation’s trend component is weighted with 50% in the modeled trend slope. The mechanics of the β smoothing parameter are the same as described for the α smoothing parameter previously.
require(smooth)
require(greybox)
require(Mcomp)


head(M3)
M3$N2457$x
es(M3$N2457$x, h=18, holdout=TRUE, silent=FALSE)
