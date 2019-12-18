#TS - Arithmetic

library(xts)
(sales = round(rnorm(n=100, mean=100, sd=15)))
(dates = seq.Date(from=as.Date('2019-01-01'), by='1 day', length.out = 100))

tssales = xts(data=sales, order.by = dates)
tssales


#cumsum
cumsum(tssales)
class(tssales)
forecast::ggmonthplot(tssales)
forecast::ggsubseriesplot(AirPassengers)
