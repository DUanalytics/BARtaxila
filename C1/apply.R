#apply functions

#apply, lapply, sapply, vapply
#20 students of 4 sections of MBA : their age
set.seed(1234)
data = round(rnorm(20, mean=25, sd=5),2) #fill by column
m1 = matrix(data, nrow=5)
m1
#1-row,2-col
#apply-----
apply(m1,MARGIN=1, FUN=mean)
#5 rows - 5 values
#MARGIN = 2 -> columnwise  :: 1 is rowwise
apply(m1,MARGIN=2, mean)
#4 cols -> 4 values
apply(m1, MARGIN = 2, FUN = c(mean, sd)) #error
#error
#create user defined function
myfunc <- function(x) {  x * 1.5 }  #curly brackets for functions
apply(X=m1, MARGIN=2, FUN=myfunc)
apply(X=m1, MARGIN=2, function(x) x + 5)  #increase age of all
m1

data
apply(data, MARGIN=1, FUN=sum)  #error
#apply needs at least 2 dimensions, vector does not have
dim(data)
dim(m1)  #matrix has rows * cols

#multiple functions using apply & userdefined functino
myfunc2 <- function(x) {  c(mean(x), sd(x), length(x))}
m1
apply(m1, MARGIN=2, FUN=myfunc2) #2 functions
#for each col: find mean, sd, count


#-----------------------------------------------
#lapply  - output in list form
data
lapply(X=data, mean)
#does not do anything useful

#three different vectors, combine into list
A = c(1:9)
B = c(1:12)
C = c(1:15)
list1 = list(A, B, C) #combine into a list
mean(A); mean(B); mean(C)
lapply(X=list1, FUN=mean)
#vector wise mean values

#----------------------------------------------
#sapply - simple form of lapply
sapply(X=list1, FUN=mean)
#output like a vector
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


#practise... practise
