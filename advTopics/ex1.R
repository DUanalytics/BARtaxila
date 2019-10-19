#questions

set.seed(1234)
(data = sample.int(12))
#12 10  6  5  4  7  1  9  2  8 11  3
(m1 = matrix(data, nrow=3, byrow = T))
matrix(data)
#

set.seed(10)
x <- rnorm(100, 1, 0.5)
str(x)

# 
set.seed(1234)
(x = trunc(runif(50, min=30, max=50)))
#32 42 42 42 47 42 30 34 43 40 43 40 35 48 35 46 35 35 33 34 36 36 33 30 34 46 40 48 46 30 39 35 36 40 33 45 34 35 49 46 41 42 36 42 36 40 43 39 34 45
hist(x, col="gray", labels = TRUE, right=F, freq=T, breaks=c(0,30,35,40,45,50))
length(x[x <= 30 | x > 45])





#





n=800
ss = .8 #class 1 & 10
(SS = .8 * 800)
(hs = 1 - ss)  #classes 11 to 12
(HS = hs * 800)
(Male = .475 * n)
(Female = 800 - Male)
(Veg = .53 * 800)
(NonVeg = 800 - Veg)
(hs = c1t)