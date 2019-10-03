#apply functions

#apply, lapply, sapply, vapply
#100 students of 5 sections of MBA : their age
set.seed(1234)
data = round(rnorm(100, mean=25, sd=5),2) #fill by column
m1 = matrix(data, nrow=20)
m1

#apply
apply(m1,MARGIN=1, FUN=mean)
#MARGIN = 1 -> columnwise  :: 2 is rowwise
apply(m1,MARGIN=2, mean)

apply(m1, MARGIN = 2, FUN = c(mean, sd)) #error
#error
#create user defined function
myfunc <- function(x) {
  x * 1.5
}
apply(X=m1, MARGIN=2, FUN=myfunc)
apply(X=m1, MARGIN=2, function(x) x + 5)

apply(data, MARGIN=1, FUN=sum)  #error
#apply needs at least 2 dimensions, vector does not have
dim(data)
dim(m1)

#multiple functions using apply & userdefined functino
myfunc2 <- function(x) {  c(mean(x), sd(x), length(x))}
apply(m1, MARGIN=2, FUN=myfunc2) #2 functions


#-----------------------------------------------
#lapply  - output in list form
data
lapply(X=data, mean)
#does not do anything useful

#three different vectors, combine into list
A = c(1:9)
B = c(1:12)
C = c(1:15)
list1 = list(A, B, C) #combine

lapply(X=list1, FUN=mean)
#vector wise mean values

#----------------------------------------------
#sapply - simple form of lapply
sapply(X=list1, FUN=mean)

#----------------------------------------
#vapply
mean(A)
vapply(X=list1, FUN=mean, FUN.VALUE = numeric(1))
#return only 1 numeric values
range(A)
vapply(X=list1, FUN=range, FUN.VALUE = numeric(2))
quantile(A)
vapply(X=list1, FUN=quantile, FUN.VALUE = numeric(5))
#2 and 5 values returned

#---------------------------------------
#tapply -  perform the apply function on some data, but have it separated by factor
m1
dfm1 = as.data.frame(m1)
head(dfm1)
gender = sample(c('M','F'), size=20, replace=T)
length(gender)
dfm2 = cbind(dfm1, gender)
dfm2
head(dfm2)
str(dfm2)
tapply(X=dfm2$V1, INDEX=dfm2$gender, FUN=mean)


#practise... practised
