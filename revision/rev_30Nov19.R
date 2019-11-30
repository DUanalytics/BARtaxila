# Revision - 30 Nov / 1 Dec
#Linear Regression

#Simple Linear-----

women  #dataset
head(women)  #plot the relation between x & y
plot(x=women$height, y=women$weight) #another way of plot
model1 = lm(weight ~ height, data = women) #create model
summary(model1)  #view the summary of the model
#parameters to be seen
#F Stats - Pvalue < .05 : there is linear relationship between Y & any x
#coeff betas : p values < .05 : significant
# ht increases, wt increases by 3.45 units
model1   #model coefficients
predict(model1, newdata=women)  #predict for orginal values of x
residuals(model1)  #difference actual y and predicted y
plot(model1)  #check assumptions of linear regression


#Part-2 : Multiple Linear Regression
# Single Y : multiple Xs
# y = c + b1x1 + b2x2 .....

head(mtcars)








