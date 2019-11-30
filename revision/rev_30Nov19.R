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
# y =  b0 + b1x1 + b2x2 .....
head(mtcars)  #first 6 rows of mtcars
#DV - mpg,  IV - wt, hp, gear
class(mtcars)  #Data frame
df = mtcars[ ,c('mpg','wt','hp','gear')] #copy selected columns to new DF df
head(df) #first 6 rows of df
pairs(df) # plot relationships of all columns of df
model2 = lm(mpg ~ wt + hp + gear , data=df) #create model : predict mpg on wt, hp, gear from data set df
summary(model2)  #summarise the model
#check the model2 output : F-Stats pv, R2, coeff, coeff-pvalue
#remove gear from the model : becoz pvalue was > .05 or it was not significant
model3 = lm(mpg ~ wt + hp , data=df) #construct new model without gear
summary(model3)  #sumarise and see the attributes of the model #model alright
predict(model3, newdata= df)  #predict for existing data
head(cbind(df, PV= predict(model3, newdata= df), RV = residuals(model3)))  #also see residuals
(ndata = data.frame(wt=3, hp=200, gear=5))  #create new card data for prediction
predict(model3, newdata=ndata) #predict for this new data
plot(model3)  #check for assumptions 

