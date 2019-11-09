#Logistic Regression : Binary Cls : 0 or 1

#Case Study :  predict if an individual will earn more than $50K using logistic regression based on demographic variables available in the adult data
library(ggplot2)
library(dplyr)
library(Amelia)  #missing values
#Steps
# Import the data
# Check for class bias
# Create training and test samples
# Compute information value to find out important variables
# Build logit models and predict on test data
# Do model diagnostics

#Data Import ----
#from URL
inputData <- read.csv("https://raw.githubusercontent.com/DUanalytics/datasets/master/csv/adult.csv", stringsAsFactors = F)
dim(inputData)
head(inputData)
str(inputData)
names(inputData)

adult = inputData  #work on copy of data
names(adult)
str(adult)
# Generating the frequency table
table(adult$workclass)

#Its better we convert the ? to NA and discard them so that the model can be efficient
sum(!complete.cases(adult))
adult[adult == "?"] <- NA #whereever ? is there replace by NA
table(adult$native.country)
table(adult$workclass)
#---------------
#Amelia package is used to map missing value in the dataset
missmap(adult, y.at = 1, y.labels = "", col = c("red", "black"), legend = FALSE)

adult <- na.omit(adult)
missmap(adult, y.at = 1, y.labels = "", col = c("red", "black"), legend = FALSE) #now missing values removed
# Now we omit the value since most NA values are present in the occupation and workclass

ggplot(adult, aes(age)) + geom_histogram(aes(fill = income), color = "black",binwidth = 1)

#in the above histogram people around the age between 25-50 tend to earn more than 50k
ggplot(adult, aes(hours.per.week)) + geom_histogram()
#It is clear that the highest frequency of hours.per.week occurs at 40.

table(adult$native.country)
names(adult)
adult %>% group_by(native.country, income) %>% summarise(n=n()) %>%  ggplot(., aes(x=reorder(native.country, n), y=n, fill=income)) + geom_bar(stat='identity', color = "black") + coord_flip()

#Building the Model The purpose of this model is to classify people into two groups, below 50k or above 50k in income. We will build the model using training data, and then predict the salary class using the test group.
# 
#Train-Test Split
library(caTools)
names(adult)
head(adult)
#make columns into categories
columns1 = c('workclass', 'education', 'marital.status', 'occupation', 'relationship', 'race', 'gender', 'native.country', 'income')
adult[, columns1]
adult[,columns1] = lapply(adult[,columns1], as.factor)
#adult[,-columns1] = lapply(adult[,-columns1], as.integer)
str(adult)

split <- sample.split(adult$income, SplitRatio = 0.7)
split
train <- subset(adult, split == TRUE)
test <- subset(adult, split == FALSE)
str(train)
#train the model
log.model <- glm(income ~ ., family = binomial(), train)
#ignore the warning
#prediction 
prediction <- predict(log.model, test, type = "response")
prediction

table(test$income, prediction >= 0.5)
table(test$income, prediction >= 0.1)

#what should be the cutoff value between 0 and 1 to categorise them into 0 or 1, so that accuracy is high (correct splitting)

#------------------------------
(prob = plogis(predict(log.model, test)))
optimalCutoff(test$income, prob)[1] 

#cutoff value
library(InformationValue)
(optCutOff <- InformationValue::optimalCutoff(test$income, predicted)[1] )

#Confusion Matrix
(cm1= confusionMatrix(test$income, predicted, threshold = optCutOff))
#0 classified as 0, 1 classified as 1



#diagnostics

car::vif(logitMod)
#all X variables in the model to have VIF below 4.

misClassError(testData$ABOVE50K, predicted, threshold = optCutOff)
#Misclassification error is the percentage mismatch of predcited vs actuals, irrespective of 1’s or 0’s. The lower the misclassification error, the better is your model.




ROC
#Receiver Operating Characteristics Curve traces the percentage of true positives accurately predicted by a given logit model as the prediction probability cutoff is lowered from 1 to 0. For a good model, as the cutoff is lowered, it should mark more of actual 1’s as positives and lesser of actual 0’s as 1’s. So for a good model, the curve should rise steeply, indicating that the TPR (Y-Axis) increases faster than the FPR (X-Axis) as the cutoff score decreases. Greater the area under the ROC curve, better the predictive ability of the model.

plotROC(testData$ABOVE50K, predicted)



#links
https://www.kaggle.com/rohithgraamani/logistic-regression-on-adult-income
https://www.kaggle.com/flyingwombat/logistic-regression-with-uci-adult-income

http://ethen8181.github.io/machine-learning/unbalanced/unbalanced.html











#http://r-statistics.co/Logistic-Regression-With-R.html
#https://rpubs.com/H_Zhu/235617