#functions applied to matrix type structure

set.seed(123)
data = rnorm(n=30, mean=60, sd=10)
data = trunc(data)

m1 = matrix(data, ncol=6)
m1
class(m1)
str(m1)  #vector in 2 dim
dim(m1)

colSums(m1)  #6 cols
colMeans(m1)
rowSums(m1)  # 5 row
rowMeans(m1)

#specific rows/ columns
colSums(m1[, c(1,3)])

#sweep
m1
sweep(m1, MARGIN = 1, STATS=5, FUN="+")
m1
sweep(m1, MARGIN = 1, STATS=c(5,6,7,8,9), FUN="+")
#add 5 to Row1, 6 to Row2  and so on
m1
sweep(m1, MARGIN = 2, STATS=1:6, FUN="-")
#subtract 1 from Col1, 2 from Col2, 3 from Col4 and so on
#sweep(m1, MARGIN = 2, STATS=1:6, FUN=c("-","+","-","-",'+',"+"))
#error


#end ------

