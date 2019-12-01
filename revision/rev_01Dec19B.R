#Revision - 01 Dec
#batch, age,gender, cgpa, ug, class12 : select, salary
nS=200
(age = round(runif(n=nS, min=20, max=30)))
mean(age)
(gender = sample(x=c('M', 'F'), size=nS, replace=T, prob=c(.7,.3)))
table(gender)
(batch = sample(x=c('2017', '2018','2019'), size=nS, replace=T, prob=c(.2,.3,.5)))
table(batch)
(cgpa = round(rnorm(n=nS,mean=7, sd=.75),2))
range(cgpa)
(ug = round(rnorm(n=nS,mean=70, sd=5),2))
range(ug)
(class12 = round(rnorm(n=nS,mean=70, sd=7),2))
range(class12)
(domain = sample(c('Finance','HR','Operations','Marketing'), size=nS, replace=T))
students = data.frame(age, gender, batch, domain, cgpa, ug, class12)
head(students)
(students$select = sample(c('Placed','NotPlaced'), size=nS, replace=T, prob=c(.7,.3)))
table(students$select)
(students$salary = round(rnorm(n=nS, mean=12, sd=1),2))
(students$salary = ifelse(students$select == 'NotPlaced',NA, students$salary))
head(students)
#summarise
nrow(students) #no of students
table(students$domain)
table(students$batch)
table(students$batch, students$domain)
table(students$batch, students$domain, students$gender)
hist(students$cgpa)
hist(students$cgpa, breaks=c(0,6.5,8.5,10))
hist(students$age)

library(dplyr)
library(ggplot2)

#gender
ggplot(students, aes(x=gender, fill=gender)) + geom_bar(stat='count') + geom_text(stat='count', aes(label=..count..))
#domain
ggplot(students, aes(x=domain, fill=domain)) + geom_bar(stat='count') + geom_text(stat='count', aes(label=..count..))
#batch
ggplot(students, aes(x=batch, fill=batch)) + geom_bar(stat='count') + geom_text(stat='count', aes(label=..count..))
#batch & domain
ggplot(students, aes(x=batch, fill=domain)) + geom_bar(stat='count') + geom_text(stat='count', aes(label=..count..), position = position_stack(), vjust=1)

ggplot(students, aes(x=batch, fill=domain)) + geom_bar(stat='count') + geom_text(stat='count', aes(label=..count..), position = position_stack(), vjust=1) + facet_grid(select ~ gender)
 
ggplot(students, aes(x=gender, fill=gender)) + geom_bar(stat='count') + geom_text(stat='count', aes(label=..count..)) + facet_grid(batch ~ domain, scales='free')
#histogram
ggplot(students, aes(x=cgpa)) + geom_histogram()
ggplot(students, aes(x=cgpa)) + geom_histogram(breaks=c(0,5,7,9,10), fill=1:4)
ggplot(students, aes(x=cgpa)) + stat_bin(bins=5, fill=1:5)

students %>% group_by(batch, domain) %>% summarise(avgSal = mean(salary, na.rm=T))

students %>% filter(batch=='2018' & select == 'Placed') %>% group_by(domain, gender) %>% summarise(meanSal = mean(salary) )

students %>% filter(batch=='2018' & select == 'Placed') %>% group_by(domain, gender) %>% summarise(meanSal = round( mean(salary),2))  %>% ggplot(., aes(x=domain, y=meanSal, fill=domain)) + geom_bar(stat='identity') + facet_grid( ~ gender) + geom_text(aes(label=meanSal))

#
students %>% group_by(batch, domain) %>% summarise(avgSal = mean(salary, na.rm=T)) %>% ggplot(., aes(x=batch, y=domain, fill=avgSal)) + geom_tile() + geom_text(aes(label=round(avgSal,2))) + ggtitle("Average Salary Offer - Domain - Year")

students %>% group_by(batch, domain, gender) %>% summarise(avgSal = mean(salary, na.rm=T)) %>% ggplot(., aes(x=batch, y=avgSal, fill=batch)) + geom_bar(stat='identity') + geom_text(aes(label=round(avgSal,2))) + ggtitle("Average Salary Offer - Domain - Year") + facet_grid(gender ~ domain)
