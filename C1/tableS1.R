#table commands

#table, addmargins, margin.table, prop.table

mtcars
str(mtcars)

#table-------
table(mtcars$cyl)

table(mtcars$cyl, mtcars$gear)
table(mtcars$cyl, mtcars$gear, dnn=c('cyl', 'gear'))
#store in expression t1
t1 = table(mtcars$cyl, mtcars$gear, dnn=c('cyl', 'gear'))
t1

#margintable------------
#sums values over margin
margin.table(t1)
margin.table(x=t1, margin=1) #cylwise
#margin-1 : rows 
margin.table(x=t1, margin=2)  #gearwise

#addmargins---------
#add different functions over the margins
addmargins(A=t1, margin=1) #default is sum; sum of each column, shown as row
addmargins(A=t1, margin=2, FUN=mean)  #mean as column of each row
addmargins(A=t1, margin=c(1,2), FUN=sum)  #sum at both row and column
addmargins(A=t1, margin=c(1,2), FUN=c(sum,mean))  #two function on rows/ col margins
#different functions in rows and columns
addmargins(A=t1, margin=c(1,2), FUN=list(list(sum,mean, length, mean), list(sd, sum)))
           
           