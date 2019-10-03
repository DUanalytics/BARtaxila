#Data Frame - create and filter
#DF has columns and row structure like excel
#each column can be of different types

mtcars  #built in DF
class(mtcars)

#simplest way
df1 = data.frame(name = c('S1','S2','S3'), age=c(22, 23, 24))
df1
#df has columnnames

#create using vectors 
(rollno  = 1:10)
(name = paste('S', 1:10, sep=''))
(age = round(rnorm(10, mean=25, sd=2),1))
(gender = sample(c('M','F'), size=10, replace=T))
df2 = data.frame(rollno, name, age, gender)
class(df2)
str(df2)
df2
head(df2)
tail(df2)
head(df2, n=7)


#filter rows/col-----
df2[1:2, 2:4]
df2[1:3, c('rollno','gender')]

#filter by condition
df2[df2$age > 25, ]
df2[df2$gender == 'M', 1:4] 
df2[df2$age < 25 & df2$gender == 'M', ]  #and
df2[df2$age > 25 | df2$gender == 'M', ]  #or

#columwise
df2$rollno
df2$name
#rowwise
df2[1, ]


#with, by
?with
with(df2, boxplot(age))  #temporary open the DF and use by column names
with(df2, mean(age))

?by
by(df2[,'age'], df2[,'gender'], FUN=mean)

?within
