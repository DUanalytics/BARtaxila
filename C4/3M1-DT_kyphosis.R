#CART - Kyphosis data

#https://www.statmethods.net/advstats/cart.html

library(rpart)
#rpart(formula, data=, method=,control=) where
#formula	is in the format
#outcome ~ predictor1+predictor2+predictor3+ect.
#data=	specifies the data frame
#method=	"class" for a classification tree
#"anova" for a regression tree
#control=	optional parameters for controlling tree growth. For example, control=rpart.control(minsplit=30, cp=0.001) requires that the minimum number of observations in a node be 30 before attempting a split and that a split must decrease the overall lack of fit by a factor of 0.001 (cost complexity factor) before being attempted.

#Examine the results
#printcp(fit)	display cp table
#plotcp(fit)	plot cross-validation results
#rsq.rpart(fit)	plot approximate R-squared and relative error for different splits (2 plots). labels are only appropriate for the "anova" method.
#print(fit)	print results
#summary(fit)	detailed results including surrogate splits
#plot(fit)	plot decision tree
#text(fit)	label the decision tree plot
#post(fit, file=)	create postscript plot of decision tree

#Prune the tree to the desired size using
#prune(fit, cp= )
#fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"]


# Classification Tree with rpart
library(rpart)
head(kyphosis)
# grow tree
fitC <- rpart(Kyphosis ~ Age + Number + Start, method="class", data=kyphosis)
fitC
printcp(fitC) # display the results
plotcp(fitC) # visualize cross-validation results
summary(fitC) # detailed summary of splits

# plot tree
plot(fitC, uniform=TRUE,    main="Classification Tree for Kyphosis")
text(fitC, use.n=TRUE, all=TRUE, cex=.8)

library(rpart.plot)
rpart.plot(fitC, extra=104, fallen.leaves = T)
prp(fitC)

# create attractive postscript plot of tree
post(fitC, file = "graphs/tree.ps",  title = "Classification Tree for Kyphosis")


#--------
# prune the tree
plotcp(fitC)
printcp(fitC)
pfitC2 <- prune(fitC, cp= fitC$cptable[which.min(fit$cptable[,"xerror"]),"CP"])
pfitC2
pfitC3 <- prune(fitC, cp=0.01)
# plot the pruned tree
plot(pfitC3, uniform=TRUE,     main="Pruned Classification Tree for Kyphosis")
text(pfitC3, use.n=TRUE, all=TRUE, cex=.8)
post(pfitC3, file = "graphs/ptree.ps",   title = "Pruned Classification Tree for Kyphosis")

rpart.plot(pfitC3)

#Regression Trees------------------------------------
library(rpart)
head(cu.summary)
cu.summary$Mileage

# grow tree
fitR <- rpart(Mileage~Price + Country + Reliability + Type,     method="anova", data=cu.summary)

printcp(fitR) # display the results
plotcp(fitR) # visualize cross-validation results
summary(fitR) # detailed summary of splits

# create additional plots
par(mfrow=c(1,2)) # two plots on one page
rsq.rpart(fitR) # visualize cross-validation results  

# plot tree
plot(fitR, uniform=TRUE,     main="Regression Tree for Mileage ")
text(fitR, use.n=TRUE, all=TRUE, cex=.8)

# create attractive postcript plot of tree
post(fitR, file = "graphs/tree2.ps",     title = "Regression Tree for Mileage ")

# prune the tree
pfitR2 <- prune(fitR, cp=0.01160389) # from cptable   

# plot the pruned tree
plot(pfitR2, uniform=TRUE,      main="Pruned Regression Tree for Mileage")
text(pfitR2, use.n=TRUE, all=TRUE, cex=.8)
post(pfitR2, file = "graphs/ptree2.ps",title = "Pruned Regression Tree for Mileage")

#
rpart.plot(pfitR2)


#----------
# Conditional Inference Tree for Kyphosis
library(party)
fitP <- ctree(Kyphosis ~ Age + Number + Start,  data=kyphosis)
plot(fitP, main="Conditional Inference Tree for Kyphosis")

# Conditional Inference Tree for Mileage
library(party)
fitP2 <- ctree(Mileage~Price + Country + Reliability + Type,data=na.omit(cu.summary))

plot(fitP2)

#-----------
# Random Forest prediction of Kyphosis data
library(randomForest)
fitRF <- randomForest(Kyphosis ~ Age + Number + Start,   data=kyphosis)
print(fitRF) # view results
importance(fitRF) # importance of each predictor
plot(fitRF)


#------------
library(randomForestSRC)
?randomForestSRC
