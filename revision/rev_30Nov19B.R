#Revision - 30 Nov
#Logistic Regression

sample(c('Y','N'), size=200, replace=T)
#Placement Drive 
#select, gender, cgpa, class12, ug
n=200
(select = sample(c('Yes','No'), size=n, replace=T, prob=c(.6,.4)))
table(select)
(gender = sample(c('M','F'), size=n, replace=T, prob=c(.75,.25)))
table(gender)
#rep('M',100)
(cgpa = round(rnorm(n, mean=7, sd=.75),2))
range(cgpa)
(class12 = round(runif(n, min=50, max=100)))
range(class12)
mean(class12)
(ug = round(runif(n, min=60, max=85)))
range(ug); mean(ug)

placement = data.frame(select, gender, cgpa, class12, ug)
head(placement)


#Logistic-------
logmodel1 = glm(select ~ gender + cgpa + class12 + ug, data=placement, family='binomial')
summary(logmodel1)
#-----------------

gredata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
## view the first few rows of the data
head(gredata)
dim(gredata)
table(gredata$rank)
str(gredata)
gredata$admit = factor(gredata$admit)
gredata$rank = factor(gredata$rank)
str(gredata)
logmodel2 = glm(admit ~ gre + gpa + rank, data = gredata, family='binomial')
summary(logmodel2)
head(gredata)
library(dplyr)
(ndata1 = sample_n(gredata, 3))

predict(logmodel2, newdata=ndata1, type='response')
ndata2 = data.frame(gre=700, gpa=3.9, rank=factor(3))
predict(logmodel2, newdata=ndata2, type='response')

#confusion matrix
PV = predict(logmodel2, newdata=gredata, type='response')
PV_Cat = ifelse(PV < .5, 0, 1)
orgValues = as.numeric(as.character(gredata$admit))
head(cbind(orgValues, PV_Cat))
t1=table(orgValues, PV_Cat)
t1
diag(t1)
sum(diag(t1))/ sum(t1)  #accuracy


#Decision Tree-----
placement
#write.csv(placement,'data/placement30Nov19.csv', row.names = F)
head(placement)
library(rpart)
library(rpart.plot)
names(placement)
dtree = rpart(select ~ gender + cgpa + class12 + ug, data= placement, method='class')
dtree
rpart.plot(dtree,cex=.7)
printcp(dtree)
ptree1 <- prune(dtree, cp=0.026)
ptree1
rpart.plot(ptree1, cex=.7, extra=104, nn=T)
prp(ptree1, cex=.7, extra=104)
rpart.rules(ptree1)
  

#http://www.milbo.org/rpart-plot/prp.pdf