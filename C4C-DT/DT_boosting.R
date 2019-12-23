#Boosted Tree


library(adabag)
library(rpart)
library(caret)
library(rpart.plot)

bank.df <- read.csv('data/UniversalBank.csv')
head(bank.df)
bank.df$Personal.Loan <- as.factor(bank.df$Personal.Loan)
#parition data
set.seed(1)
train.index <- sample(c(1:nrow(bank.df)), size=.6 * nrow(bank.df))
train.df <- bank.df[train.index,]
test.df <- bank.df[-train.index, ]
lapply(list(train.df, test.df), dim)

names(train.df)
#classification Tree
default.ct <- rpart(Personal.Loan ~ ., data = train.df, method='class')
#plot tree
default.ct
prp(default.ct, type=1, extra=1,under=T, split.font=1, varlen=10)
rpart.plot(default.ct, extra=104, nn=T)


#longer/deeper tree 
deeper.ct <- rpart(Personal.Loan ~ ., data = train.df, cp=0, minsplit=1, method='class')
#plot tree
deeper.ct
prp(deeper.ct, type=1, extra=1,under=T, split.font=1, varlen=10)
rpart.plot(deeper.ct, extra=104, nn=T)
#no of trees
length(deeper.ct$frame$var[deeper.ct$frame$var == "<leaf>"])
#43 nodes

#predict - training data
default.ct.point.pred.train <- predict(default.ct, train.df, type='class')
table(default.ct.point.pred.train)
#confusion matrix
confusionMatrix(default.ct.point.pred.train, factor(train.df$Personal.Loan))
#98.7%

#predict - test/validated data- Default Tree
default.ct.point.pred.test <- predict(default.ct, test.df, type='class')
table(default.ct.point.pred.test)
#confusion matrix
confusionMatrix(default.ct.point.pred.test, factor(test.df$Personal.Loan))
#98%

#predict - test/validated data- Deeper Tree
deeper.ct.point.pred.test <- predict(deeper.ct, test.df, type='class')
table(deeper.ct.point.pred.test)
#confusion matrix
confusionMatrix(deeper.ct.point.pred.test, factor(test.df$Personal.Loan))
#98.05%

#CP
cv.ct <- rpart(Personal.Loan ~ ., data = train.df, cp=0.00001, minsplit=5, method='class', xval=5)
printcp(cv.ct)
#choose cv where xerror is least -> row6 -> cp=.009
pruned.ct <- prune(cv.ct, cp = .0009)
length(pruned.ct$frame$var[pruned.ct$frame$var == '<leaf>'])
#29
prp(pruned.ct, type=1, extra=1, split.font=1, varlen = 10, cex=.7)
rpart.plot(pruned.ct, extra=104,nn=T, cex=.6, fallen.leaves = FALSE)

#target should be category/ factor type
boost <- boosting(Personal.Loan ~ ., data= train.df)
pred <- predict(boost, test.df)
table(pred$class)
confusionMatrix(factor(pred$class), factor(test.df$Personal.Loan))
#98.4  better
#Boosting. Building multiple models (typically of the same type) each of which learns to fix the prediction errors of a prior model in the chain.


library(ipred)
bag <- bagging(Personal.Loan ~ ., data= train.df)
bag
pred_bg <- predict(bag, test.df)
table(pred_bg)
confusionMatrix(factor(pred_bg), factor(test.df$Personal.Loan))
#Bagging. Building multiple models (typically of the same type) from different subsamples of the training dataset

#videos
https://www.youtube.com/watch?v=aBYC_n7DNqI
https://www.youtube.com/watch?v=6q63Fwx33sg

#98.4