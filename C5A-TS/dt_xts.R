#xts

library(xts)
#xts  or the Extensible Time Series is one of such packages that offers such a time series object. It's a powerful R package that provides an extensible time series class, enabling uniform handling of many R time series classes by extending zoo, 
#xts objects have three main components:
#coredata: always a matrix for xts objects
#index: vector of any Date, POSIXct, chron, yearmon, yearqtr, or DateTime classes
#xtsAttributes: arbitrary attributes

xts1 <- xts(x=1:10, order.by=Sys.Date()-1:10)
xts1

data <- rnorm(5)
dates <- seq(as.Date("2019-12-01"), length=5, by="days")
xts2 <- xts(x=data, order.by=dates)
xts2

xts3 <- xts(x=rnorm(10), order.by=as.POSIXct(Sys.Date()+1:10), born=as.POSIXct("1899-05-08"))
xts3

xts4 <- xts(x=1:10, order.by=Sys.Date()+1:10)
xts4            


#Convert To And From xts
data(AirPassengers)
AirPassengers

xts5 <- as.xts(AirPassengers)
xts5

coredata(xts5)
index(xts5)
indexClass(xts5)
#indexClass(convertIndex(xts,'POSIXct'))
indexTZ(xts5)
tzone(xts5)
to.yearly(xts5) #like stock market OHLC
to.monthly(xts5)
to.quarterly(xts5)
to.period(xts5,period="quarters")  #average months to qtr
to.period(xts5,period="years")
nmonths(xts5)
nquarters(xts5)
nyears(xts5)

.index(xts5) #numeric index
.indexwday(xts5)
.indexhour(xts5)
time(xts5)

#export
#data_xts <- as.xts(matrix)
#tmp <- tempfile()
#write.zoo(data_xts,sep=",",file=tmp)

#replace
xts2[dates] <- 0 
xts5["1961"] <- NA
xts2[dates] <- 0 


#functions
ep1 <- endpoints(xts4,on="weeks",k=2)  
ep1
ep2 <- endpoints(xts5,on="years") 
ep2


#Calculate the yearly mean 
period.apply(xts5,INDEX=ep2,FUN=mean)

xts5_yearly <- split(xts5,f="years")
xts5_yearly
lapply(xts5_yearly,FUN=mean) 

Find the last observation in each year in xts5

do.call(rbind,  lapply(split(xts5,"years"), function(w) last(w,n="1 month"))) 

Calculate cumulative annual passengers

do.call(rbind,  lapply(split(xts5,"years"),  cumsum)) 

#Apply standard deviation to rolling margins of xts5

rollapply(xts5, 3, sd) 

#Select
mar55 <- xts5["1955-03"] #Get value for March 1955
mar55
Get all data from 1954 

(xts5_1954 <- xts5["1954"] )

#Extract data from Jan to March ‘54 

(xts5_janmarch <- xts5["1954/1954-03"])

#Get all data until March ‘54  
(xts5_janmarch <- xts5["/1954-03"] )

xts4[ep1] 

first(xts4,'1 week') #Extract first 1 week
first(last(xts4,'1 week'),'3 days') #Get first 3 days of the last week of data


days <- c("2017-05-03","2017-05-23") 
xts3[days] 


(index<-which(.indexwday(xts1)==0|.indexwday(xts1)==6) )

na.omit(xts5) 

#Fill missing values in xts2 using last observation
(xts_last <- na.locf(xts2) )

#Fill missing values in xts2 using next observation
(xts_last <- na.locf(xts2,  fromLast=TRUE))

#Interpolate NAs
na.approx(xts2)


#Operations
xts3 + as.numeric(xts2) #Addition
xts3 * as.numeric(xts4) #Multiplication
coredata(xts4) - xts3 #Subtraction
coredata(xts4) / xts3 #Division


#shift
xts5 - lag(xts5) 
diff(xts5,lag=12,differences=1) 

merge(xts2,xts1,join='inner') # Inner join of xts2 and xts1
merge(xts2,xts1,join='left',fill=0) #Left join of xts2 and xts1,
rbind(xts1, xts4)



#https://www.datacamp.com/community/blog/r-xts-cheat-sheet