#Linear Programming : 
#Chocolate Manufacturing
#


#https://www.analyticsvidhya.com/blog/2017/02/lintroductory-guide-on-linear-programming-explained-in-simple-english/
#http://civil.colorado.edu/~balajir/CVEN5393/R-sessions/sess1/lpSolveAPI-vignettes.pdf
#https://www.r-bloggers.com/linear-programming-in-r-an-lpsolveapi-example/


#2-------
#A toy manufacturing organization manufactures two types of toys A and B. Both the toys are sold at Rs.25 and Rs.20 respectively. There are 2000 resource units available every day from which the toy A requires 20 units while toy B requires 12 units. Both of these toys require a production time of 5 minutes. Total working hours are 9 hours a day. What should be the manufacturing quantity for each of the pipes to maximize the profits?
#Max.Z=25x+20y : Constraints:   20x+12y<=2000 and 5x+5y<=540
#Setting the coefficients of decision variables
objective.in=c(25,20)
#Constraint Matrix
(const.mat=matrix(c(20,12,5,5),nrow = 2,byrow = T))
#defining constraints
const_time=540; const_res=2000
#RHS for constraints
const.rhs=c(const_res,const_time)
#Direction for constraints
const.dir=c("<=","<=")
#Finding the optimum solution
opt=lp(direction = "max",objective.in,const.mat,const.dir,const.rhs)
summary(opt)
#Objective values of x and y
opt$solution
#Value of objective function at optimal point
opt$objval

#2b- LPsolveAPI-----
my.lp <- make.lp(nrow=2, ncol=2)  #rows-contraint 
my.lp  
# The best way to build a model in lp solve is columnwise;
#that is to set the columns then the objective function then the constraint types andfinally the right-hand-side
set.column(my.lp, 1, c(5, 20))  #first column
my.lp
set.column(my.lp, 2, c(5, 12)) #2nd colun
my.lp
set.objfn(my.lp, c(25, 20)) #profit of 5 & 12 - A & B
my.lp
set.constr.type(my.lp, c("<=", "<=")) # milk =5, choco=12
set.rhs(my.lp, c(540, 2000))
set.type(my.lp, c(1,2), "integer")  #no of A & B - integer value
my.lp
#set objective direction : Maximisation
lp.control(my.lp,sense='max')
my.lp

#I in order to be able to visually check the model, to a text file
write.lp(my.lp,'model.lp',type='lp')
#solve the model, if this return 0 an optimal solution is found
solve(my.lp)
#this return the proposed solution
get.objective(my.lp)
get.variables(my.lp)
get.constraints(my.lp) 
get.solutioncount(my.lp)
get.primal.solution(my.lp)
get.dual.solution(my.lp)
get.sensitivity.objex(my.lp)
get.sensitivity.obj(my.lp)
get.basis(my.lp)

#https://cran.r-project.org/web/packages/lpSolveAPI/lpSolveAPI.pdf

