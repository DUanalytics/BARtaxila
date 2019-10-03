#Data Frame summary

mtcars
str(mtcars)
class(mtcars)
summary(mtcars) 
dim(mtcars)  #32 rows, 11 columns


#table-------
table(mtcars$cyl,mtcars$gear)  #count Gear vs Cyl
#1 cars with gear4 and cyl3
table(mtcars$cyl,mtcars$gear, dnn=c('Cyl','Gear'))  #count Gear vs Cyl ; dnn - dimension names

table(mtcars$cyl,mtcars$gear, mtcars$carb)  #3 dim
#Matrix-Carb8 - rows-gear, col-Cyl

#xtabs------
xtabs(formula =  ~ cyl + gear, data=mtcars)
xtabs(formula =  ~ cyl + gear + carb, data=mtcars)

#aggregate-------
?aggregate
aggregate(x=mtcars, by=list(mtcars$gear), FUN=mean)
aggregate(x=mtcars[,c('mpg','hp')], by=list(mtcars$gear), FUN=mean)
#gear then cyl : aggregation
aggregate(x=mtcars[,c('mpg','hp')], by=list(mtcars$gear, mtcars$cyl), FUN=mean)
aggregate(x=mtcars[,c('mpg','hp')], by=list(mtcars$gear, mtcars$cyl), FUN=sd)  #function can be any statistics

#formula method
aggregate(formula = mpg ~ gear, data=mtcars, FUN=mean)
aggregate(x=mtcars[,c('mpg')], by=list(mtcars$gear), FUN=mean)  #old method
#mean of mpg & hp wrt gear types
aggregate(formula = cbind(mpg, hp) ~ gear, data=mtcars, FUN=mean)
#mean of mpg wrt gear & cyl types
aggregate(formula = mpg ~ gear + cyl, data=mtcars, FUN=mean)
#mean of mpg, hp & wt wrt gear & cyl types
aggregate(formula = cbind(mpg,hp,wt) ~ gear + cyl, data=mtcars, FUN=mean)

#this is better, columns clear

#more functions 
aggregate(formula = mpg ~ gear, data=mtcars, FUN=function(x) c(MEAN= mean(x), SD = sd(x), COUNT= length(x)))
aggregate(formula = cbind(mpg, hp) ~ gear, data=mtcars, FUN=function(x) c(MEAN= mean(x), SD = sd(x), COUNT= length(x)))


#end -----
          