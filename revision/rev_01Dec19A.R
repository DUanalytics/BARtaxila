#Plots using Placement analysis
library(dplyr)
library(ggplot2)

#student Profile
#select, gender, cgpa, class12, ug
n=200
(rollno = paste('Taxila',100:(100+n-1),sep='-'))
length(rollno)
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
students = data.frame(rollno, gender, cgpa, class12, ug)
head(students)

#placement Drives
(drives = paste('Drive',1:5,sep='-'))
rollno
(driveResults = expand.grid(rollno, drives))
#200 students x 5 drives = 1000 rows
nrow(driveResults)
names(driveResults) = c('rollno', 'driveNo')
head(driveResults)
(driveResults$select = sample(c('Yes','No'), size=nrow(driveResults), replace=T, prob=c(.3,.7)))
table(driveResults$select)
head(driveResults)
driveResults$salary = round(rnorm(nrow(driveResults), mean=8, sd=1),2)
driveResults$salary = ifelse(driveResults$select == 'No', NA, driveResults$salary)
head(driveResults)

#Placement Drive 
names(students); names(driveResults)
head(students)
placementResults = merge(students, driveResults, by.x='rollno', by.y='rollno', all.x=T)
head(placementResults)

#data ready for analysis

#student Profile
#gender
head(students)
barplot(table(students$gender))
hist(students$cgpa)
hist(students$class12)
hist(students$ug)
attach(students)
plot(density(students$cgpa))
plot(density(students$class12), col='red')
lines(density(students$ug), col='blue')
plot(density(students$ug))
