#Time Series - Rainfall
library(ggplot2)
library(quantmod)
library(timeSeries)
require(timeSeries)
require(xts)
require(PerformanceAnalytics)
require(fTrading)
#timeseries.object.name <-  ts(data, start, end, frequency)
#Following is the description of the parameters used −
#data is a vector or matrix containing the values used in the time series.
#start specifies the start time for the first observation in time series.
#end specifies the end time for the last observation in time series.
#frequency specifies the number of observations per unit time.
#Except the parameter "data" all other parameters are optional.

# Get the data points in form of a R vector.
(rainfall <- c(799,1174.8,865.1,1334.6,635.4,918.5,685.5,998.6,784.2,985,882.8,1071))

# Convert it to a time series object.
(rainfall.timeseries <- ts(rainfall,start = c(2019,1),frequency = 12))

# Print the timeseries data.
print(rainfall.timeseries)
plot(rainfall.timeseries)

#ggplot(rainfall.timeseries) + geom_line()
#https://cran.r-project.org/web/packages/timeSeries/vignettes/timeSeriesPlot.pdf

#Stock Rates

library(tidyquant)
getSymbols("AAPL", from = '2019-01-01',   to = "2019-12-20",warnings = FALSE, auto.assign = TRUE)
AAPL
head(AAPL)
tail(AAPL)
class(AAPL)

quantmod::chart_Series(AAPL)
chart_Series(AAPL['2019-10/2019-12'])

#several Stocks
tickers = c("SBIN.NS", "ICICIBANK.NS", "TATAMOTORS.NS")

getSymbols(tickers, from = "2018-01-01",   to = "2019-12-15")
SBIN.NS
ICICIBANK.NS
TATAMOTORS.NS

stocks = as.xts(data.frame(SBIN = SBIN.NS[, "SBIN.NS.Close"], ICICI = ICICIBANK.NS[, "ICICIBANK.NS.Close"], TATAMOTORS = TATAMOTORS.NS[, "TATAMOTORS.NS.Close"]))
head(stocks)

plot(as.zoo(stocks), screens = 1, lty = 1:3, col=1:3, main='Indian Stock Rates', xlab = "Date", ylab = "Price")
legend("topright", c("SBIN", "ICICI", "TATATMOTORS"), lty = 1:3, col=1:3, cex = 0.5)

class(stocks)
head(stocks)
fortify(stocks)  #convert to DF which is required by ggplot
stocksDF = fortify(stocks)
str(stocksDF)

autoplot(stocks)

tsbox::ts_ggplot(stocks) 

stocksDF[1:100,] %>% dplyr::mutate(Index=as.Date(Index)) %>% reshape2::melt(id.vars='Index') %>% ggplot(aes(x = Index, y = value, group=variable)) +  geom_line(aes(color=variable)) +    labs(x = 'Date',    y = "Closing Price",   title = "Indian Stocks") + scale_x_date(date_labels = "%b/%Y") 

stocksDF[1:100,] %>% dplyr::mutate(Index=as.Date(Index)) %>% reshape2::melt(id.vars='Index') %>% ggplot(aes(x = Index, y = value, group=variable)) +  geom_area(aes(fill=variable), alpha=.3) +    labs(x = 'Date',    y = "Closing Price",   title = "Indian Stocks") + scale_x_date(date_labels = "%b/%Y") 


#group by month
(ep = endpoints(stocks,'months'))
period.apply(stocks,INDEX=ep,FUN=mean)
period.apply(stocks,INDEX=ep,FUN=sum)
apply.daily(stocks, FUN=mean)
head(stocks)
head(apply.daily(stocks, FUN=sum))  #sum columns
apply.weekly(stocks, FUN=sum)
apply.monthly(x=stocks, FUN=mean)
apply.quarterly(x=stocks, FUN=mean)
apply.yearly(x=stocks, FUN=mean)
apply.yearly(x=stocks, FUN=mean, na.rm=T)

fortify(apply.monthly(x=stocks, FUN=mean, na.rm=T))  %>% dplyr::mutate(Index=as.Date(Index)) %>% reshape2::melt(id.vars='Index') %>% ggplot(aes(x = Index, y = value, group=variable)) +  geom_line(aes(color=variable), size=2) +  labs(x = 'Date',    y = "Monthly Closing Price", title = "Indian Stocks: Monthly Closing Averages") + geom_text(aes(label=round(value))) + scale_x_date(date_breaks = "1 month", date_minor_breaks = "1 week", date_labels = "%b :: %V") + theme(axis.text.x = element_text(angle=30)) + geom_vline(xintercept = as.Date(c('2019-06-01', '2019-10-01')))
start(stocks); end(stocks)
#https://cran.r-project.org/web/packages/timeSeries/vignettes/timeSeriesPlot.pdf
#https://www.codingfinance.com/post/2018-03-27-download-price/
#https://jangorecki.gitlab.io/data.table/library/xts/html/apply.monthly.html




library(zoo)
rollmean(c(4,5,4,6), 3)
