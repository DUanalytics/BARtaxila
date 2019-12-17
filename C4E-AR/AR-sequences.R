

#install.packages("arulesSequences")
library(arulesSequences)
load('data/traffic.RData')

traffic


frequent_pattern <-cspade(traffic.tran,parameter = list(support = 0.50))
inspect(frequent_pattern)

#https://subscription.packtpub.com/book/big_data_and_business_intelligence/9781784390815/9/ch09lvl1sec103/creating-transactions-with-temporal-information
