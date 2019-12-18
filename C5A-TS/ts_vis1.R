# Time Series Plots


data("AirPassengers")

plot(AirPassengers)

seasonplot(AirPassengers)

#create time series

library(fpp2)
fpp2::arrivals
head(arrivals)
class(arrivals)
autoplot(arrivals)
autoplot(arrivals, facets = TRUE)
autoplot(arrivals, facets = TRUE) +  geom_smooth()

autoplot(fpp2::qcement)
ggseasonplot(qcement, year.labels=FALSE, continuous=TRUE)
# left
ggseasonplot(a10, year.labels=FALSE, continuous=TRUE)

#right
ggseasonplot(a10, year.labels=FALSE, continuous=TRUE, polar = TRUE)
ggsubseriesplot(qcement)


# left: autoplot of the beer data
autoplot(ausbeer)

# middle: lag plot of the beer data
gglagplot(ausbeer)

# right: ACF plot of the beer data
ggAcf(ausbeer)




#-----------------------Not working -------------------
library(tsviz)
head(crypto_prices)
#A dataset closing prices for Litecoin, Bitcoin and Ethereum on 1174 days, between 2016-04-01 and 2019-07-01. Prices are recorded in US dollars.
if(interactive()){
  prices <- tsviz::crypto_prices
  tsviz::tsviz()
}
#An RStudio addin to visualize time series. Time series are supposed to be contained into a data.frame object in the global environment, with the following format:   • a column of type Date • one of more numeric column
(data = round(rnorm(30, mean=60, sd=10)))
(m1 = matrix(data, ncol=5))
colnames(m1) = paste('P',1:5, sep='')
m1
(df = as.data.frame(m1))
# Create dates as a Date class object starting from 2016-01-01
(df$Date = seq(as.Date("2019-12-01"), length = 6, by = "days"))
df = df[, c('Date','P1','P2','P3','P4','P5')]
df
str(df)
tsviz::tsviz()

#https://uc-r.github.io/ts_exploration
#https://cran.r-project.org/web/packages/tsviz/tsviz.pdf