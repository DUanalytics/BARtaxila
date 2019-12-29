#Exponential Smoothing

#simple
#Using the R-Package ‘forecast’, we enter the following code for simple exponential smoothing. Beta is a parameter of Holt-Winters Filter. If set to FALSE, the function will do exponential smoothing. Gamma is a parameter used for the seasonal component. If set to FALSE, a non-seasonal model is fitted. So, with both beta and gamma set to FALSE, we get single exponential smoothing.
#Single-----
library(expsmooth)
data(unemp.cci)
head(unemp.cci)
period(unemp.cci)
cycle(unemp.cci)

library(ggfortify)

cci <- ts(unemp.cci[,"cci"],start=c(1997))
plot.ts(cci)
autoplot(unemp.cci)
autoplot(cci)
autoplot(decompose(cci))

cci.smooth<- HoltWinters(cci, beta=FALSE, gamma=FALSE)
plot(cci.smooth$fitted)



#es() is a part of smooth package. It allows constructing Exponential Smoothing (also known as ETS), selecting the most appropriate one among 30 possible

library(smooth)  #for ets

require(Mcomp)  #for data
data(M3) #time series from the M3 forecasting competition.
class(M3) #different format

class(M3$N2457$x)  #We will select this (Historical)
M3$N2457$x
range(M3$N2457$x)

require(greybox)# some of the functions of the greybox package.
?greybox

#TS analysis
plot(M3$N2457$x)
plot(decompose(M3$N2457$x))

es(M3$N2457$x, h=18, holdout=TRUE, silent=FALSE)
es(M3$N2457$x, h=18, holdout=TRUE, interval=TRUE, silent=FALSE)
ourModel <- es(M3$N2457$x, h=18, holdout=TRUE, silent="all")
es(M3$N2457$x, model=ourModel, h=18, holdout=FALSE, interval="np", level=0.93)
modelType(ourModel)
actuals(ourModel)
es(M3$N2457$x, model=modelType(ourModel), h=18, holdout=FALSE, initial=ourModel$initial, silent="graph")
es(M3$N2457$x, model=modelType(ourModel), h=18, holdout=FALSE, persistence=ourModel$persistence, silent="graph")
es(M3$N2457$x, model=modelType(ourModel), h=18, holdout=FALSE, initial=1500, silent="graph")
es(M3$N2457$x, h=18, holdout=TRUE, loss="aTMSE", bounds="a", ic="BIC", interval=TRUE)
es(M3$N2457$x, model="CCN", h=18, holdout=TRUE, silent="graph")

es(M3$N2457$x, model=c("CCC","ANN","AAN","AAdN","ANA","AAA","AAdA"), h=18, holdout=TRUE, silent="graph")

etsModel <- forecast::ets(M3$N2457$x)
esModel <- es(M3$N2457$x, model=etsModel, h=18)
esModel
forecast(etsModel,h=18,level=0.95)
forecast(esModel,h=18,level=0.95)
es(M3$N2457, interval=TRUE, silent=FALSE)




#https://ourcodingclub.github.io/2017/04/26/time.html
