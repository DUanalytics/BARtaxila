#Stock Prices - Analysis

library(quantmod)
library(xts)
library(rvest)
library(tidyverse)
library(stringr)
library(forcats)
library(lubridate)
library(plotly)
library(dplyr)
library(PerformanceAnalytics)

getSymbols("AMZN",from="2008-08-01",to="2018-08-17")
AMZN_log_returns <- AMZN%>%Ad()%>%dailyReturn(type='log')

AMZN %>% Ad() %>% chartSeries()
#The first chart series graph is straightforward as it shows Amazon’s price chart:
AMZN %>% chartSeries(TA='addBBands();addVo();addMACD()',subset='2018')
#second chart series show the Bollinger Band chart, % Bollinger change, Volume Traded and Moving Average Convergence Diverence in 2018 alone:


#The moving average is important to understanding Amazon(AMZN)’s technical charts. It smoothes out daily price fluctuations by averaging stock prices and is effective in identifying potential trends.

#The Bollinger Band chart plots two standard deviations away from the moving average and is used to measure the stock’s volatiliy. The Volume chart shows how its stocks are traded on the daily. The Moving Average Convergence Divergence gives technical analysts buy/sell signals. The rule of thumb is: If it falls below the line, it is time to sell. If it rises above the line, it is experiencing an upward momentum.

#The charts above are usually used to decide whether to buy/sell a stock. Do more reearch

#https://towardsdatascience.com/analyzing-stocks-using-r-550be7f5f20d
