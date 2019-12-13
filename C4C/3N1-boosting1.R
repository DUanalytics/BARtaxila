#Boosting
#for predicting the probability of being diabetes positive based on multiple clinical variables.

library(tidyverse)
library(caret)
library(xgboost)

#Randomly split the data into training set (80% for building a predictive model) and test set (20% for evaluating the model). Make sure to set seed for reproducibility.

# Load the data and remove NAs
data("PimaIndiansDiabetes2", package = "mlbench")
PimaIndiansDiabetes2 <- na.omit(PimaIndiansDiabetes2)
# Inspect the data
sample_n(PimaIndiansDiabetes2, 3)
# Split the data into training and test set
set.seed(123)
training.samples <- PimaIndiansDiabetes2$diabetes %>%   createDataPartition(p = 0.8, list = FALSE)
training.samples  #index no of samples
train.data  <- PimaIndiansDiabetes2[training.samples, ]
test.data <- PimaIndiansDiabetes2[-training.samples, ]

#cart
library(rpart)
library(rpart.plot)
cartModel = rpart(diabetes ~ ., data = train.data, method='class')
cartModel
printcp(cartModel)
pcartModel = prune(cartModel, cp=.01)
rpart.plot(pcartModel, cex=.8)
predict1 = predict(pcartModel, test.data, type='class')
predict1
mean(predict1 == test.data$diabetes)  #accuracy


#Boosted classification trees
# Fit the model on the training set
set.seed(123)
model <- train(   diabetes ~., data = train.data, method = "xgbTree",   trControl = trainControl("cv", number = 10))

# Best tuning parameter
model$bestTune

# Make predictions on the test data
predicted.classes <- model %>% predict(test.data)
head(predicted.classes)

# Compute model prediction accuracy rate
mean(predicted.classes == test.data$diabetes)
#79%

#The function varImp() [in caret] displays the importance of variables in percentage:
  
varImp(model)


#Regression
#Similarly, you can build a random forest model to perform regression, that is to predict a continuous variable.

#Example of data set
#We’ll use the Boston data set [in MASS package],  for predicting the median house value (mdev), in Boston Suburbs, using different predictor variables.

#Randomly split the data into training set (80% for building a predictive model) and test set (20% for evaluating the model).

# Load the data
data("Boston", package = "MASS")
# Inspect the data
sample_n(Boston, 3)
# Split the data into training and test set
set.seed(123)
training.samples <- Boston$medv %>%   createDataPartition(p = 0.8, list = FALSE)
train.data  <- Boston[training.samples, ]
test.data <- Boston[-training.samples, ]


Boosted regression trees
Here the prediction error is measured by the RMSE, which corresponds to the average difference between the observed known values of the outcome and the predicted value by the model.

# Fit the model on the training set
set.seed(123)
model <- train(   medv ~., data = train.data, method = "xgbTree",   trControl = trainControl("cv", number = 10)
)
# Best tuning parameter mtry
model$bestTune
# Make predictions on the test data
predictions <- model %>% predict(test.data)
head(predictions)
# Compute the average prediction error RMSE
RMSE(predictions, test.data$medv)

#We’ll use the caret workflow, which invokes the xgboost package, to automatically adjust the model parameter values, and fit the final best boosted tree that explains the best our data.



#http://www.sthda.com/english/articles/35-statistical-machine-learning-essentials/139-gradient-boosting-essentials-in-r-using-xgboost/
