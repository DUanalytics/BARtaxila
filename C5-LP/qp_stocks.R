# #Quadratic Programming
# 

# Quadratic programming is a model where both the objective function is a quadratic function (contains up to two term products) while constraint function is restricted as linear combination of variables.
# 
# The Quadratic Programming problem can be defined as follows ...
# 
# Minimize quadratic objective function:
#   f(x1, x2) = c1.x12 + c2. x1x2 + c2.x22 - (d1. x1 + d2.x2)
# Subject to constraints
# a11.x1 + a12.x2 == b1
# a21.x1 + a22.x2 == b2
# a31.x1 + a32.x2 >= b3
# a41.x1 + a42.x2 >= b4
# a51.x1 + a52.x2 >= b5
# Express the problem in Matrix form:
#   
#   Minimize objective ½(DTx) - dTx
# Subject to constraint ATx >= b
# First k columns of A is equality constraint
# 
# As an illustrative example, lets continue on the portfolio investment problem.  In the example, we want to find an optimal way to allocate the proportion of asset in our investment portfolio.
# StockA gives 5% return on average
# StockB gives 4% return on average
# StockC gives 6% return on average
# We also look into the variance of each stock (known as risk) as well as the covariance between stocks.
# # For investment, we not only want to have a high expected return, but also a low variance.  In other words, stocks with high return but also high variance is not very attractive.  Therefore, maximize the expected return and minimize the variance is the typical investment strategy.
# # One way to minimize variance is to pick multiple stocks (in a portfolio) to diversify the investment.  Diversification happens when the stock components within the portfolio moves from their average in different direction (hence the variance is reduced).
# # The Covariance matrix ∑ (between each pairs of stocks) is given as follows:
#   1%, 0.2%, 0.5%
# 0.2%, 0.8%, 0.6%
# 0.5%, 0.6%, 1.2%
# # In this example, we want to achieve a overall return of at least 5.2% of return while minimizing the variance of return
# # To formulate the problem:
#   #   Variable: x1 = % investment in A, x2 = % in B, x3 = % in C
# # Minimize variance: xT∑x
# # Subjected to constraint:
#   x1 + x2 + x3 == 1
# X1*5% + x2*4% + x3*6% >= 5.2%
#   0% < x1, x2, x3 < 100%

library(quadprog)
mu_return_vector <- c(0.05, 0.04, 0.06) 
sigma <- matrix(c(0.01, 0.002, 0.005, 0.002, 0.008, 0.006, 0.005, 0.006, 0.012),  nrow=3, ncol=3)
D.Matrix <- 2*sigma
d.Vector <- rep(0, 3)
A.Equality <- matrix(c(1,1,1), ncol=1)
A.Matrix <- cbind(A.Equality, mu_return_vector, diag(3))
b.Vector <- c(1, 0.052, rep(0, 3))
out <- solve.QP(Dmat=D.Matrix, dvec=d.Vector, Amat=A.Matrix, bvec=b.Vector, meq=1)
out$solution
#[1] 0.4 0.2 0.4
out$value
#[1] 0.00672

#http://horicky.blogspot.com/2013/01/optimization-in-r.html