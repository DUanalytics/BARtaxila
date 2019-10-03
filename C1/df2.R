#Data Frame summary

mtcars
str(mtcars)
class(mtcars)
summary(mtcars)

#table
table(mtcars$cyl,mtcars$gear)
table(mtcars$cyl,mtcars$gear, mtcars$carb)

#xtabs
xtabs(formula =  ~ cyl + gear, data=mtcars)
xtabs(formula =  ~ cyl + gear + carb, data=mtcars)

#aggregate
?aggregate
aggregate(x=mtcars, by=list(mtcars$gear), FUN=mean)
aggregate(x=mtcars[,c('mpg','hp')], by=list(mtcars$gear), FUN=mean)
#gear then cyl : aggregation
aggregate(x=mtcars[,c('mpg','hp')], by=list(mtcars$gear, mtcars$cyl), FUN=mean)

#formula method
aggregate(formula = mpg ~ gear, data=mtcars, FUN=mean)
aggregate(formula = cbind(mpg, hp) ~ gear, data=mtcars, FUN=mean)
aggregate(formula = mpg ~ gear + cyl, data=mtcars, FUN=mean)
aggregate(formula = cbind(mpg,hp,wt) ~ gear + cyl, data=mtcars, FUN=mean)

#this is better, columns clear

#more functions 
afuncs1 <- function(x) {
  mean(x)
  sd(x)
  length(x)
}
aggregate(formula = mpg ~ gear, data=mtcars, FUN=function(x) c(MEAN= mean(x), SD = sd(x), COUNT= length(x)))
aggregate(formula = cbind(mpg, hp) ~ gear, data=mtcars, FUN=function(x) c(MEAN= mean(x), SD = sd(x), COUNT= length(x)))

          