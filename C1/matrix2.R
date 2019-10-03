#functions applied to matrix type structure

set.seed(123)
data = rnorm(n=30, mean=60, sd=10)
data = trunc(data)

m1 = matrix(data, ncol=6)
m1

colSums(m1)
colMeans(m1)
rowSums(m1)
rowMeans(m1)

#specific rows/ columns
colSums(m1[, c(1,3)])
