#Decision Tree - Boston Data set
#https://medium.com/analytics-vidhya/a-guide-to-machine-learning-in-r-for-beginners-decision-trees-c24dfd490abb
#dataset corresponds to a census tract 
url = "https://raw.githubusercontent.com/parulnith/A-guide-to-Machine-Learning-in-R/master/Decision%20Trees/boston.csv"

boston = read.csv(url)

#LON and LAT are the longitude and latitude of the center of the census tract.
# MEDV is the median value of owner-occupied homes, measured
# in thousands of dollars.
# CRIM is the per capita crime rate.
# ZN is related to how much of the land is zoned for large residential properties.
# INDUS is the proportion of the area used for industry.
# CHAS is 1 if a census tract is next to the Charles River else 0 
# NOX is the concentration of nitrous oxides in the air, a measure of air pollution.
# RM is the average number of rooms per dwelling.
# AGE is the proportion of owner-occupied units built before 1940.
# DIS is a measure of how far the tract is from centres of employment in Boston.
# RAD is a measure of closeness to important highways.
# TAX is the property tax per $10,000 of value.
# PTRATIO is the pupil to teacher ratio by town.
#----
#here MEDV is the output /target variable i.e price of the house to be predicted. Since the output variable is continuos it is an example of regression tree.

#Understand data -----
str(boston)
dim(boston)
names(boston)
# Plot observations
plot(boston$LON, boston$LAT)
#The dense central core of points corresponds to Boston city, and other urban cities. Since, we also have the Charles river attribute(CHAS), we want to also show all the points that lie along the Charles River in a blue colour.

# Tracts alongside the Charles River
points(boston$LON[boston$CHAS==1], boston$LAT[boston$CHAS==1], col="blue", pch=19)
#this data set was originally constructed to investigate questions about how air pollution affects prices. The air pollution variable in the data is NOX. 
# Plot pollution/NOX 
summary(boston$NOX)
#Let’s look at the tracts that have above-average pollution.
points(boston$LON[boston$NOX>=0.55], boston$LAT[boston$NOX>=0.55], col="green", pch=20)
#All the points that have got above-average pollution are coloured green.
#Now it kind of makes sense, since, the area most densely polluted is the one which is also most densely populated.
#Now let us look at how the prices vary over the area as well. 

# Plot prices
plot(boston$LON, boston$LAT)
summary(boston$MEDV)
points(boston$LON[boston$MEDV>=21.2], boston$LAT[boston$MEDV>=21.2], col="red", pch=20)
#So what we see now are all the census tracts with above-average housing prices in red.
#However, the census tracts of above-average and below-average are mixed in between each other.But there are some patterns.For example, look at that dense black bit in the middle. That corresponds to most of the city of Boston, especially the southern parts of the city. So there’s definitely some structure to it, but it’s certainly not simple in relation to latitude and longitude at least.



#CART-----
library(rpart); library(rpart.plot)
# CART model
latlontree = rpart(MEDV ~ LAT + LON, data=boston)
# Plot the tree using prp command defined in rpart.plot package
prp(latlontree)
#The leaves of the tree are important.
#In a classification tree, the leaves would be the classification that we assign .
#In regression trees, we instead predict the number.That number here is the average of the median house prices in that bucket.

#visulaise output
plot(boston$LON, boston$LAT)
points(boston$LON[boston$MEDV>=21.2],boston$LAT[boston$MEDV>=21.2], col="red", pch=20)

fittedvalues = predict(latlontree)
points(boston$LON[fittedvalues>21.2],boston$LAT[fittedvalues>=21.2], col="blue", pch="$")


#minbucket
latlontree = rpart(MEDV ~ LAT + LON, data=boston, minbucket=50)
plot(latlontree)
text(latlontree)


#Split
# Split the data
library(caTools)
set.seed(123)
split = sample.split(boston$MEDV, SplitRatio = 0.7)
train = subset(boston, split==TRUE)
test = subset(boston, split==FALSE)

# Create a CART model
tree = rpart(MEDV ~ LAT + LON + CRIM + ZN + INDUS + CHAS + NOX + RM + AGE + DIS + RAD + TAX + PTRATIO, data=train)
prp(tree)
#Results:  Latitude and Longitude aren’t really important
#The rooms are the most important split.
#Pollution appears in there twice, so it’s, in some sense, nonlinear on the amount of pollution i.e if it’s greater than a certain amount or less than a certain amount, it does different things.
#Very nonlinear on the number of rooms.

tree.pred = predict(tree, newdata=test)
tree.sse = sum((tree.pred - test$MEDV)^2)
tree.sse


#The model has very high chances of “over-fitting”. Infact it is the key challenge in case of Decision Trees. If no limit is set, in the worst case, it will end up putting each observation into a leaf node.
#There are techniques which help in improving the performance of Decision Trees. We can improve the results of our Decision Trees using the “cp” parameter. Also, we can try and implement Cross Validation, a technique to avoid overfitting in predictive models. 