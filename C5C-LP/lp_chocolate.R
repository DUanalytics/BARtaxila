#Linear Programming - Chocolate

library(lpSolveAPI)
#Consider a chocolate manufacturing company which produces only two types of chocolate – A and B. Both the chocolates require Milk and Choco only.  To manufacture each unit of A and B, following quantities are required:
#Each unit of A requires 1 unit of Milk and 3 units of Choco
#Each unit of B requires 1 unit of Milk and 2 units of Choco
#The company kitchen has a total of 5 units of Milk and 12 units of Choco. On each sale, the company makes a profit of #Rs 6 per unit A sold : Rs 5 per unit B sold.
#Now, the company wishes to maximize its profit. How many units of A and B should it produce respectively?

#Choco   Milk	 Choco	Profit per unit
#A(X)	     1	    3	 Rs 6
#B(Y)       1     2	 Rs 5
#Total(Z)   5	   12	
# total profit the company makes is given by the total number of units of A and B produced multiplied by its per unit profit Rs 6 and Rs 5 respectively.
#Profit: Max Z = 6X+5Y  #which means we have to maximize Z.
#resources Milk and Choco are available in limited amount.
#As per the above table, each unit of A and B requires 1 unit of Milk. The total amount of Milk available is 5 units. To represent this mathematically,
#X+Y ≤ 5
#each unit of A and B requires 3 units & 2 units of Choco respectively. The total amount of Choco available is 12 units. To represent this mathematically,
#3X+2Y ≤ 12
#the values for units of A can only be integers. So we have two more constraints, X ≥ 0  &  Y ≥ 0

#Method-1:
library(lpSolveAPI)
#linear program model object with 2 constraints(Milk & Choco) and 2  decision variables(A & B).
my.lp <- make.lp(nrow=2, ncol=2)
dimnames(my.lp) <- list(c("Milk", "Choco"),c("Chocolate-A", "Chocolate-B"))
my.lp
#columns are Types of Choco with demand qty and Rows are Resources with constraints

lp.control(my.lp,sense='max') #set objective direction : Maximisation
my.lp
# The best way to build a model in lp solve is columnwise;#that is to set the columns then the objective function then the constraint types and finally the right-hand-side
set.column(my.lp, 1, c(1, 3))  #first column
my.lp
set.column(my.lp, 2, c(1, 2)) #2nd coln
my.lp
set.constr.type(my.lp, c("<=", "<=")) # milk =5, choco=12
my.lp
set.rhs(my.lp, c(5, 12))
my.lp
set.type(my.lp, c(1,2), "integer")  #no of A & B - integer value
my.lp
set.objfn(my.lp, c(6, 12)) #profit of 5 & 12 - A & B : either set as column or objfn
my.lp
#I in order to be able to visually check the model, to a text file
write.lp(my.lp,'lp.chocolate',type='lp')
#solve the model, if this return 0 an optimal solution is found
solve(my.lp)
#this return the proposed solution
get.objective(my.lp)  #60
get.variables(my.lp)
get.constraints(my.lp) #how much of milk & choco used
get.solutioncount(my.lp)  #should be 1
get.primal.solution(my.lp)  #details
#get.dual.solution(my.lp)
#get.sensitivity.objex(my.lp)
#get.sensitivity.obj(my.lp)
get.bounds(my.lp)

#from other library : lpSolve
library(lpSolve)
#Setting the coefficients of decision variables
objective_in=c(6,12)
#Constraint Matrix
(const_mat=matrix(c(1,1,3,2),nrow = 2,byrow = T))
#defining constraints
const_milk=5; const_choco=12
#RHS for constraints
const_rhs=c(const_milk,const_choco)
#Direction for constraints
const_dir=c("<=","<=")
#Finding the optimum solution
opt=lp(direction = "max", const.mat = const_mat, objective.in = objective_in, const.dir = const_dir,const.rhs=const_rhs)
summary(opt)
#Objective values of x and y
opt$solution  #A-0, B=5
opt$const.count
#Value of objective function at optimal point
opt$objval  #profit of 60
opt$x.count
opt$constraints
opt$status
