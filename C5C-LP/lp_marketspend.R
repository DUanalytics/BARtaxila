#LP - Marketing Spend Budget

#Chief Marketing Officer(CMO) of a company asks the digital marketing manager to allocate an annual budget of 10,00,000 Rs among 4 channels: AdWords, Facebook, email and affiliated such that the number of users visits their website. Cost of acquisition per user from each channel will be 250,200,150 and 100 respectively. Lifetime value (LTV) of the customer from each channel will be 1500,800,300 and 100 respectively. CMO further says that he wants a minimum of 1000 users from each of Adwords and facebook channels and a minimum of 500 users from each email and affiliated. Budget for facebook and adwords together should not exceed 600000. LTV should be more than 500.
#CHANNEL	   CAC	LTV	   Min_Users
#AdWords	   250	1500	1000
#FaceBook	   200	800	  1000
#Email	     150	300	  500
#Affiliated	 100	100	  500

#Decision variables: Budget to be allocated to each channel say B1,B2,B3,B4

#Objective function :   Maximize Number  of  Users = B1/250+B2/200+B3/100+B4/150
#make.lp function is used to create new object of linear program model.
#ncol is the number of variables in the problem.
#lp.control is used to set parameters to the lp model like sense=“max” is used to indicate that it is a maximization problem and verbose=“neutral” will not generate any error report.

library(lpSolveAPI)
model <- make.lp(ncol=4)
m1 <- lp.control(model, sense="max", verbose="neutral")
m1
model
#min user constraints : Adwords :: B1/250 >=1000; FB :: B2/200 >=1000 ;Email :: B3/150 >=500 ; Affiliated :: B4/100>=500
m2 <- set.objfn(model, obj=round(c(1/250,1/200,1/150,1/100),4))
model
m3 <- set.bounds(model, lower=c(250000,200000,75000,50000))
model
#FB and Adwords Budget Constraint:: B1+B2<=600000
m4 <- add.constraint(model, c(1,1,0,0), "<=",600000)
model
#Total Budget Constraint :: B1+B2+B3+B4 <=1000000
m5<-add.constraint(model, c(1,1,1,1), type="<=",1000000)
model
#Minimum LTV Constraint::
m6 <- add.constraint(model, round(c((1500/250-500/250),(800/200-500/200),(300/150-500/150),(100/100-500/100)),4), type=">=",0)
model
rownames=c("facebook&Adword","total budget","LTV")
colnames=c("Adword","Facebook","Email","Affiliated")
dimnames(model)=list(rownames,colnames)
name.lp(model,"Maximize Number Of Users")
model
write.lp(model, filename="lp_model.lp")
kableExtra::kable(readLines("lp_model.lp"))
solve(model)
get.variables(model)
#get.variables returns the values of the variables after optimization.
get.objective(model)
#The budget allocated to AdWords is 337500, Facebook is 200000, email is 75000 and affiliated is 387500.
#get.objective is used to return the value of objective function after solving the model
#The maximum number of users in a year through all the channels of digital marketing is 6725.

#Linear Programming techniques are used not only in digital marketing but also in the HR domain, Logistics, Manufacturing etc.

#
#https://analyticsprofile.com/business-analytics/how-to-optimise-digital-marketing-spend-using-linear-programming-in-r/