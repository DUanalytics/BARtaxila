#Add.Margins, Margin.Tabel, Prop.Table

?mtcars
#it is dataframe, but all values in numbers, can be converted to matrix of numbers

m2 = as.matrix(mtcars)
class(m2)
head(m2)
m2[1, 1:2]
m2[1:5, 2:4]
str(m2)
dim(m2)

#using various summary

mt1 <- table(mtcars$gear, mtcars$cyl, dnn=c('gear','cyl'))
class(mt1)
#table is also like matrix
#margin.table--------------------------------------
?margin.table  #sum of table entries for given index
margin.table(mt1)           
margin.table(mt1, margin=1)           
margin.table(mt1, margin=2)           
margin.table(mt1, margin=c(1,2))  #original form



#addmargins-------------------------------------
?addmargins
addmargins(A=mt1,margin=1, FUN=sum)
addmargins(A=mt1,margin=2, FUN=sum)
addmargins(A=mt1,margin=c(1,2), FUN=sum)
addmargins(A=mt1,margin=c(1,2), FUN=list(sum, mean))
addmargins(A=mt1,margin=c(1,2), FUN=list(list(sum, mean), list(sd, sum)))


#prop.table---------------------------------------
?prop.table #table as fractions of marginal Table
mt1
addmargins(A=mt1, margin = 1, FUN=sum)
#Gear-3, Cyl-2 : 2/(1+2+12) 
2/15  #/133
prop.table(x=mt1, margin = 1)
.067 + .133 + .80 #sum: Gear3 row : = 1 
addmargins(prop.table(x=mt1, margin = 1), margin=2, FUN=sum)
prop.table(x=mt1, margin = 2)

prop.table(x=mt1)
mt1
2/32 #Gear3, Cyl6 : 2/32 = .062 = 6.2 % cars
matrix(paste(prop.table(x=mt1)*100 , '%', sep=''), ncol=3)


#fast, quick, short code

       