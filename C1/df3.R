#Data Frame 
#Operations in R: sort, rank, order.

#Sort()----------------------
#You can sort your data according to certain variable in dataset using order() fxn.
# Sort by column 'd' in dataset df in ascending order.
df1 <- df[order(df$d),]
head(df1)

# Sort by column 'd' in dataset df in descending order.
df2 <- df[order(-df$d),]
head(df2)

#sort, rank, order, sample using dataset "mtcars".
head(mtcars)

#sort : one column only : by mpg
sort(mtcars$mpg) # one column, increasing order
sort(mtcars$mpg, decreasing = T) # one column; decreasing order

#order : sort column in DF and print DF in that order
mtcars[order(mtcars$mpg),][1:5] #Sort DF by mpg and print only 1:5 cols

mtcars[order(mtcars$cyl, mtcars$mpg), c('cyl','mpg','wt')] #Sort DF by cyl, mpg

mtcars[order(mtcars$cyl, -mtcars$mpg), c('cyl','mpg','wt')] # increasing cyl, descreasing mpg

# rank():
x=c(1,2,36,3, 3)
rank(x)
rank(x, ties.method = 'min') #incase of tie: min rank
rank(x, ties.method = 'max') #incase of tie : higher rank

rank(mtcars$mpg, ties.method = 'min')
(rorder =cbind(mtcars$mpg, rank(mtcars$mpg, ties.method = 'min')))
#which mpg which rank
df2 = mtcars
df2$mpgrank = rank(mtcars$mpg, ties.method = 'min')
head(df2)
df2[order(df2$mpgrank), c('mpg', 'mpgrank', 'hp')]

#end