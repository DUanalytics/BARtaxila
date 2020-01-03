#LP - Stock Returns

#Linear programming is a model where both the objective function and constraint function is restricted as linear combination of variables.  The Linear Programming problem can be defined as follows ...
#Maximize objective function: f(x1, x2) = c1.x1 + c2.x2

#Subjected to inequality constraints:
#a11.x1 + a12.x2 <= b1
#a21.x1 + a22.x2 <= b2
#a31.x1 + a32.x2 <= b3
#x1 >= 0, x2 >=0

#As an illustrative example, lets walkthrough a portfolio investment problem.  In the example, we want to find an optimal way to allocate the proportion of asset in our investment portfolio.
#StockA gives 5% return on average
#StockB gives 4% return on average
#StockC gives 6% return on average
#To set some constraints, lets say my investment in C must be less than sum of A, B.  Also, investment in A cannot be more than twice of B.  Finally, at least 10% of investment in each stock.

#to formulate this problem:
#Variable: x1 = % investment in A, x2 = % in B, x3 = % in C
#Maximize expected return: f(x1, x2, x3) = x1*5% + x2*4% + x3*6%
#Subjected to constraints:
#10% < x1, x2, x3 < 100%
#x1 + x2 + x3 = 1
#x3 < x1 + x2
#x1 < 2 * x2


library(lpSolveAPI)
# Set the number of vars
model <- make.lp(0, 3)
# Define the object function: for Minimize, use -ve
set.objfn(model, c(-0.05, -0.04, -0.06))
model
# Add the constraints
add.constraint(model, c(1, 1, 1), "=", 1)
add.constraint(model, c(1, 1, -1), ">", 0)
add.constraint(model, c(1, -2, 0), "<", 0)
model
# Set the upper and lower bounds
set.bounds(model, lower=c(0.1, 0.1, 0.1), upper=c(1, 1, 1))
# Compute the optimized model
solve(model)
# Get the value of the optimized parameters
get.variables(model)
#  [1] 0.3333333 0.1666667 0.5000000
# Get the value of the objective function
get.objective(model)
#  [1] -0.05333333
# Get the value of the constraint
get.constraints(model)
#[1] 1 0 0

