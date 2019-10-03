#Matrix
#matrix is a collection of data elements arranged in a two-dimensional rectangular layout. 

set.seed(123)
data = rnorm(n=30, mean=60, sd=10)
data = trunc(data)

m1 = matrix(data, ncol=6)
m1

(m2 = matrix(data, nrow=6))
(m2R = matrix(data, nrow=6, byrow = T))

#filter values
m1 [ m1 > 50]  #vector form
m1 > 50  #T/F

#filter rows/ columns
m1[1:2, ]
m1[ , 1:3]
m1[c(1,3), c(2,5)]
m1[3,4]

