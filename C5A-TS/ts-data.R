#Time Series Data

#Daily data There could be a weekly cycle or annual cycle. So the frequency could be 7 or 365.25.

#Some of the years have 366 days (leap years). So if your time series data has longer periods, it is better to use frequency = 365.25. This takes care of the leap year as well which may come in your data.

#Weekly data There could be an annual cycle. frequency = 52 and if you want to take care of leap years then use frequency = 365.25/7

#Monthly data Cycle is of one year. So frequency = 12

#Quarterly data Again cycle is of one year. So frequency = 4

#Yearly data Frequency = 1


#http://manishbarnwal.com/blog/2017/05/03/time_series_and_forecasting_using_R/
# # How about frequency for smaller interval time series
# Hourly The cycles could be a day, a week, a year. Corresponding frequencies could be 24, 24 X 7, 24 X 7 X 365.25
# # Half-hourly The cycle could be a day, a week, a year. Corresponding frequencies could be 48, 48 X 7, 48 X 7 X 365.25
# # Minutes The cycle could be hourly, daily, weekly, annual. Corresponding frequencies would be 60, 60 X 24, 60 X 24 X 7, 60 X 24 X 365.25
# # Seconds The cycle could be a minute, hourly, daily, weekly, annual. Corresponding frequencies would be 60, 60 X 60, 60 X 60 X 24, 60 X 60 X 24 X 7, 60 X 60 X 24 X 365.25
# # You might have observed, I have not included monthly cycles in any of the time series be it daily or weekly, minutes, etc. The short answer is, it is rare to have monthly seasonality in time series. To read more on this visit monthly-seasonality.
# # Now that we understand what is time series and how frequency is associated with it let us look at some practical examples.
# # Some useful packages
# forecast: For forecasting functions
# # tseries: For unit root tests and GARC models
# # Mcomp: Time series data from forecasting competitions
# # fma: For data
# # expsmooth: For data
# # fpp: For data

#------------
# Some simple forecasting methods
# These are benchmark methods. You shouldn't use them. You will see why. These are naive and basic methods.
# 
# Mean method: Forecast of all future values is equal to mean of historical data Mean: meanf(x, h=10)
# 
# Naive method: Forecasts equal to last observed value Optimal for efficient stock markets naive(x, h=10) or rwf(x, h=10); rwf stands for random walk function
# 
# Seasonal Naive method: Forecast equal to last historical value in the same season snaive(x, h=10)
# 
# Drift method: Forecasts equal to last value plus average change Equivalent to extrapolating the line between the first and last observations rwf(x, drift = T, h=10)
# 
# 
# Forecast objects in R
# Functions that output a forecast object are:
# 
# meanf()
# 
# croston() Method used in supply chain forecast. For example to forecast the number of spare parts required in weekend
# 
# holt(), hw()
# 
# stlf()
# 
# ses() Simple exponential smoothing
# 
# Once you train a forecast model on a time series object, the model returns an output of forecast class that contains the following:
# 
# Original series
# 
# Point forecasts
# 
# Prediction intervals
# 
# Forecasting method used
# 
# Residuals and in-sample one-step forecasts

#-----------------
Measures of forecast accuracy
MAE: Mean Absolute Error

MSE or RMSE: Mean Square Error or Root Mean Square Error

MAE, MSE, RMSE are scale dependent.

MAPE is scale independent but is only sensible if the time series values >>0 for all i and y has a natural zero