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

logmodel1 = glm(select ~ gender + cgpa + class12 + ug, data=placement, family='binomial')
summary(logmodel1)
#-----------------
