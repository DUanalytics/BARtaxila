#missing values
#data may be missing for various reasons- not filled, not available, do not want to fill
#it is important to find these missing values and plan for its remedial measures - impute/ replace, remove those data points, etc
#missing values in R are indicated by NA
#when we import from excel / CSV, data may be missing, it is automatically converted to NA

#create vector 
(v1 = c(1, 5, 10, 11, 15, 25))
(v2 = c('a','b','c', 'Dhiraj', 'Abhinav', 'Kanika'))
(v3 = c(10, NA, 20, 50, NA, NA))
(v4 = c('a', NA, NA, NA, 'Abinav', NA))
is.na(v1)
is.na(v2)
is.na(v3)
sum(is.na(v3))  # 3 missing values : it counts TRUE's
is.na(v4)
sum(is.na(v4))

#arithmetic operations with missing values in vector
sum(v1)
v3
sum(v3) #sum not calculated becoz of missing values
sum(v3, na.rm=T)  #remove missing values and then sum
mean(v3)
v3
mean(v3, na.rm=T)
(10+20+50)/3

#impute / replace
v3  #replace missing values with mean of the vector
v3[is.na(v3)] = mean(v3, na.rm=T)
v3
#this can be max, min 
(v4 = c(1:10, rep(NA, 5), 20:25))
is.na(v4)
sum(is.na(v4))
v4[is.na(v4)] = 50
v4

#finding missing values in dataframe; install this package
library(VIM) #this has dataset sleep with missing values
data(sleep, package='VIM')
head(sleep) #first few rows of sleep
dim(sleep)  #dimensions of sleep data
complete.cases(sleep)  # which row have complete data in T/ F
sum(complete.cases(sleep))  # no of rows have which no missing data
sum(!complete.cases(sleep))  # no of rows which have missing data
sleep[complete.cases(sleep),]  #rows which are complete
sleep[!complete.cases(sleep),] #rows which have missing values
summary(sleep)
colSums(is.na(sleep))  #which column how many data missing
rowSums(is.na(sleep))  #which row how many data missing

df= sleep #make a copy of sleep data
colSums(is.na(df))  #dream has 12 missing values
complete.cases(df) #complete cases
mean(df$Dream, na.rm=T) #mean of Dream Col
summary(df)
df[ , 4:5]  #4th & 5th col - see missing values
df[ , c(1,3,5)] #1,3, 5 th row - see missing values
df[is.na(df$Dream),] #rows which have missing values in Dream Column
df[is.na(df$Dream), 'Dream'] #missing values in Dream Column (Vector column - data to replace here)
df[is.na(df$Dream), 'Dream'] = mean(df$Dream, na.rm=T)
colSums(is.na(df))  #Dream does not have missing values now

#do the similar actions for NonD
df[is.na(df$NonD), 'NonD'] = mean(df$NonD, na.rm=T)
colSums(is.na(df))
df
#and so on 
#use for loop
df=sleep
colSums(is.na(df))
for(i in 1:ncol(df)){
  df[is.na(df[,i]), i] <- mean(df[,i], na.rm = TRUE)
}
colSums(is.na(df))


#end