
women
head(women)
fit = lm(formula = weight ~ height, data =women)
summary(fit)

mtcars
names(mtcars)
fit2 = lm(mpg ~ hp + wt + disp + gear + am, data=mtcars)
summary(fit2)
fit3 = lm(mpg ~ hp + wt, data=mtcars)
summary(fit3)

fit4 = lm(wt ~ .........., data=mtcars)
summary(fit4)

fit4 = lm(wt~hp+gear,data=mtcars)
summary(fit4)


#logistic regresssiom
#predict DV (categorical) based in IV (continuous or categorical)

head(mtcars)
df = mtcars
head(df)
logR1 = glm(am ~ mpg + wt + disp, data=df, family='binomial')
summary(logR1)
logR2 = glm(am ~wt , data=df, family='binomial')
summary(logR2)
AIC(logR1, logR2)


fit3  #linear regression
logR2 #logistic Regression

#------------------------------------------------------
df = mtcars #copy mtcars into df
fit3 = lm(mpg ~ wt + hp, data=df) #create linear model 
#predicct mpg on wt & hp
fit3  #print the model
summary(fit3) #see the summary of the model
#R2, Adjst R2, F-Stats, P-value of T-Stats ...
(newdf = data.frame(wt=c(3,4,5,6), hp=c(300,400,100,200))) #create test values for prediction
#y = 37  - 3.8 * w - 0.03 * h
w=3; h=300
(y = 37  - 3.8 * w - 0.03 * h)
#--------
w=4; h=400
(y = 37  - 3.8 * w - 0.03 * h)
#----
newdf
predict(fit3, newdata=newdf)# predict 
cbind(newdf, mpg=predict(fit3, newdata=newdf))
#
library(dplyr)
test1 <- df %>% sample_n(2)
test1
predict(fit3, newdata=test1)

cbind(predict(fit3, newdata=test1), test1$mpg)

rbind(df,df)
cbind(df,df)
subset(df, am ==0 &  vs==1)


#decision tree

df
library(rpart)
library(rpart.plot)

tree1 = rpart(am ~ ., data=df, method='class')
tree1
rpart.plot(tree1)
rpart.plot(tree1, cex=1, extra=104, nn=T)

tree2 = rpart(mpg ~ ., data=df, method='anova')
tree2
rpart.plot(tree2)
rpart.plot(tree2, cex=1, nn=T)
(newdf = sample_n(df,2))
predict(tree2, newdata = newdf)
