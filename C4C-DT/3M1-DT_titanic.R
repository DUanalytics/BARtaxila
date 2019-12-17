#CART - titanic
#https://rpubs.com/minma/cart_with_rpart


library(rpart)
library(rpart.plot)
data(ptitanic)

str(ptitanic)

# Step1: Begin with a small cp. 
set.seed(123)
tree <- rpart(survived ~ ., data = ptitanic, control = rpart.control(cp = 0.0001))
tree
# Step2: Pick the tree size that minimizes misclassification rate (i.e. prediction error).
# Prediction error rate in training data = Root node error * rel error * 100%
# Prediction error rate in cross-validation = Root node error * xerror * 100%
# Hence we want the cp value (with a simpler tree) that minimizes the xerror. 
printcp(tree)

options(scipen = 999)
(bestcp <- tree$cptable[which.min(tree$cptable[,"xerror"]),"CP"])
# Step3: Prune the tree using the best cp.
(tree.pruned <- prune(tree, cp = bestcp))

# confusion matrix (training data)
(conf.matrix <- table(ptitanic$survived, predict(tree.pruned,type="class")))
rownames(conf.matrix) <- paste("Actual", rownames(conf.matrix), sep = ":")
colnames(conf.matrix) <- paste("Pred", colnames(conf.matrix), sep = ":")
print(conf.matrix)


plot(tree.pruned)
text(tree.pruned, cex = 0.8, use.n = TRUE, xpd = TRUE)
# use.n = TRUE adds number of observations at each node
# xpd = TRUE keeps the labels from exteding outside the plot

prp(tree.pruned, faclen = 0, cex = 0.8, extra = 1)
# faclen = 0 means to use full names of the factor labels
# extra = 1 adds number of observations at each node; equivalent to using use.n = TRUE in plot.rpart