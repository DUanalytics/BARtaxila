#base to ggplot

library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

#base & ggplot
hist(df$mpg, main='Base Plot - Histogram')
ggplot(data=df, aes(x=mpg)) + geom_histogram() + ggtitle('ggplot - Histogram')

hist(df$mpg, breaks=5, col='green', main='Base Plot - Histogram')
ggplot(data=df, aes(x=mpg)) + geom_histogram(bins=5, fill='green', colour='red') + ggtitle('ggplot - Histogram')

hist(df$mpg, breaks=c(0,10,15,20,25,40), col=1:5, main='Base Plot - Histogram'))
ggplot(data=df, aes(x=mpg)) + geom_histogram(breaks=c(0,10,15,20,25,40), fill=1:5) + ggtitle('ggplot - Histogram')

#barplot
barplot(table(df$gear), main='Base Plot - Bar Plot')
ggplot(data=df, aes(x=gear)) + geom_bar(stat='count') + labs('ggplot - Barplot')

barplot(table(df$gear), col=1:3, main='Base Plot - Bar Plot with Colors')
ggplot(data=df, aes(x=gear)) + geom_bar(stat='count', fill=1:3) + ggtitle('ggplot - Bar with Colors')

#boxplot
boxplot(df$mpg)
ggplot(data=df, aes(x="",y=mpg)) + geom_boxplot()

boxplot(formula = mpg ~ gear, data=df, col=1:3, main='Base - Box Plot')
ggplot(data=df, aes(x=gear, y=mpg, fill=gear)) + geom_boxplot() + ggtitle('ggplot - Box Plot')

#pair plot
pairs(df[,c('mpg','wt', 'hp', 'disp')], main="Base - Pair Plot ")

library(GGally)
ggpairs(df, columns=c('mpg','wt', 'hp', 'disp')) + ggtitle("ggplot - ggally - Pair Plot")
ggpairs(df, columns=c('mpg','wt', 'hp', 'disp'), aes(fill=am)) + ggtitle("ggplot - ggally - Pair Plot")


#pie
pie(table(df$cyl), main='Base - Pie Plot')
ggplot(data = df, aes(x="", fill=cyl)) + geom_bar(stat='count', position='stack') + coord_polar("y") + ggtitle('ggplot - Pie Plot')
