#box Plot
#used for continuous values to depict 5 number summary
library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

sapply(df, class)


mtcars
summary(mtcars$mpg)
quantile(mtcars$mpg)

#box plot with line showing mean of mpg 
boxplot(x=mtcars$mpg)
abline(h=mean(mtcars$mpg))

#box plot with lines showing quantile values of mpg 
boxplot(x=mtcars$mpg, col='green')
abline(h=quantile(mtcars$mpg))  

quantile(mtcars$mpg)
qvalues = c(10, 20, 30)
#box plot with lines showing user defined points
boxplot(x=mtcars$mpg, col='yellow')
abline(h=qvalues, col=1:3)  
#specifying col 1 to 3 : maps to R colours

#---------------ggplot---------------
#summaries
library(ggplot2)
ggplot(df, aes(x='', y=mpg)) + geom_boxplot()
ggplot(df, aes(x=cyl, y=mpg, group=cyl)) + geom_boxplot()

ggplot(df, aes(x=cyl, y=mpg, fill=factor(cyl))) + geom_boxplot() + facet_grid(~ gear)

#boxplot with mean
p =ggplot(df, aes(x=factor(gear), y=mpg)) + geom_boxplot()
p
p + stat_summary(fun.y = 'mean', geom='point', size=5, shape=23, fill='blue') 
p + stat_summary(fun.y = 'min', geom='point', size=5, shape=23, fill='blue') 
p + stat_summary(fun.y = c('max'), geom='point', size=5, shape=23, fill='blue') 
?stat_summary
#multiple labels
p + stat_summary(fun.y = 'min', geom='point', size=5, shape=23, fill='green') + stat_summary(fun.y = 'mean', geom='point', size=5, shape=23, fill='blue') + stat_summary(fun.y = 'max', geom='point', size=5, shape=23, fill='red') + stat_summary(fun.y = 'median', geom='point', size=5, shape=23, fill='yellow') 


d <- ggplot(df, aes(cyl, mpg)) + geom_point()
d + stat_summary(fun.data = "mean_cl_boot", colour = "red", size = 2)

d + stat_summary(fun.y = "median", colour = "red", size = 2, geom = "point")
d + aes(colour = factor(vs)) + stat_summary(fun.y = mean, geom="line")
d + stat_summary(fun.y = mean, fun.ymin = min, fun.ymax = max, colour = "red")




#https://ggplot2.tidyverse.org/reference/stat_summary.html