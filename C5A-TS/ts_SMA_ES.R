#TS - SMA, ES

library(TTR)

#Moving average
?ttrc
data(ttrc)
ttrc; dim(ttrc)
head(ttrc)


# Moving Averages
sma <- SMA(ttrc[,"Close"], n=20)
sma
?EMA
ema <- EMA(ttrc[,"Close"], n=20)
ema






#https://github.com/joshuaulrich/TTR
