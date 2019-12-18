#TS - SMA, ES

library(TTR)

#Moving average
data(ttrc)
ttrc
head(ttrc)


# Moving Averages
ema <- EMA(ttrc[,"Close"], n=20)
ema

sma <- SMA(ttrc[,"Close"], n=20)
sma





#https://github.com/joshuaulrich/TTR
