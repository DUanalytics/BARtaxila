#xts 2
#creating XTS objects

library(xts)
#xts - matrix of observations combined with an index of corresponding dates and times.

#xts = matrix + times The main xts constructor takes a number of arguments, but the two most important are x for the data and order.by for the index. x must be a vector or matrix. order.by is a vector which must be the same length or number of rows as x, be a proper time or date object (very important!), and be in increasing order.

# Create the object data using 5 random numbers
(data = round(rnorm(30, mean=60, sd=10)))
(m1 = matrix(data, ncol=5))
colnames(m1) = paste('P',1:5, sep='')
m1
# Create dates as a Date class object starting from 2016-01-01
(dates1 = seq(as.Date("2019-12-01"), length = 6, by = "days"))

# Use xts() 
(salesP5A = xts(x = m1, order.by = dates1))
#sales data of 5 products, 6 days

coredata(salesP5A)
index(salesP5A)
plot(salesP5A)
#sales figure of another 2 products
(m2 = matrix(data=round(rnorm(6*2, mean=40, sd=5)), ncol=2))
colnames(m2) =c(paste('P',6:7, sep=''))
m2
(salesP5B = xts(x = m2, order.by = dates1))
plot(salesP5B)

(allproducts=merge(salesP5A, salesP5B, join='inner'))
plot(allproducts)
autoplot(allproducts)
