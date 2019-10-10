#base to ggplot

library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

#base & ggplot------
#histogram------
hist(df$mpg, main='Base Plot - Histogram')
ggplot(data=df, aes(x=mpg)) + geom_histogram() + ggtitle('ggplot - Histogram')

hist(df$mpg, breaks=5, col='green', main='Base Plot - Histogram')
ggplot(data=df, aes(x=mpg)) + geom_histogram(bins=5, fill='green', colour='red') + ggtitle('ggplot - Histogram')

hist(df$mpg, breaks=c(0,10,15,20,25,40), col=1:5, main='Base Plot - Histogram'))
ggplot(data=df, aes(x=mpg)) + geom_histogram(breaks=c(0,10,15,20,25,40), fill=1:5) + ggtitle('ggplot - Histogram')

#barplot-----
barplot(table(df$gear), main='Base Plot - Bar Plot')
ggplot(data=df, aes(x=gear)) + geom_bar(stat='count') + labs('ggplot - Barplot')

barplot(table(df$gear), col=1:3, main='Base Plot - Bar Plot with Colors')
ggplot(data=df, aes(x=gear)) + geom_bar(stat='count', fill=1:3) + ggtitle('ggplot - Bar with Colors')

#boxplot----
boxplot(df$mpg)
ggplot(data=df, aes(x="",y=mpg)) + geom_boxplot()

boxplot(formula = mpg ~ gear, data=df, col=1:3, main='Base - Box Plot')
ggplot(data=df, aes(x=gear, y=mpg, fill=gear)) + geom_boxplot() + ggtitle('ggplot - Box Plot')

#scatterplot-----
plot(df$wt, df$mpg, main='Base - Scatter Plot')
ggplot(data=df, aes(x=wt, y=mpg)) + geom_point() + ggtitle('ggplot - Scatter Plot')

table(df$gear)
plot(df$wt, df$mpg, main='Base - Scatter Plot', col=df$gear, pch=24)
legend(x="topright",legend=c("Gear3","Gear4", "Gear5"), col=c("red","blue","green"), pch=24)
ggplot(data=df, aes(x=wt, y=mpg, fill=gear)) + geom_point(pch=24) + ggtitle('ggplot - Scatter Plot')

#lineplot -----
#https://www.datanovia.com/en/blog/line-types-in-r-the-ultimate-guide-for-r-base-plot-and-ggplot/
plot(x=df$wt, y=df$mpg, type = "l", lty = 1) #M1
lines(x=df$wt, y=df$mpg, type = "l", lty = 1)#M2.
#wt not sorted
df1= df[order(df$wt),]
plot(x=df1$wt, y=df1$mpg, type = "l", lty = 1, col='red') #M1
lines(x=df1$wt, y=df1$mpg, type = "l", lty = 1 ,lwd=2, col=3, main='Base - Line Plot')  #M2.
plot(x=df1$wt, y=df1$mpg, type = "b", lty = 1, col='red') #M3

ggplot(data=df, aes(x=wt, y=mpg)) + geom_line() + ggtitle('ggplot - Scatter Plot')
#wt sorted
ggplot(data=df, aes(x=wt, y=mpg)) + geom_line(lty=1, lwd=2, color=3) + ggtitle('ggplot - Scatter Plot')
ggplot(data=df, aes(x=wt, y=mpg)) + geom_point(fill='red', size=3, pch=23) + geom_line(lty=1, lwd=1, color=3) + ggtitle('ggplot - Scatter Plot')

#pair plot-----
pairs(df[,c('mpg','wt', 'hp', 'disp')], main="Base - Pair Plot ")

library(GGally)
ggpairs(df, columns=c('mpg','wt', 'hp', 'disp')) + ggtitle("ggplot - ggally - Pair Plot")
ggpairs(df, columns=c('mpg','wt', 'hp', 'disp'), aes(fill=am)) + ggtitle("ggplot - ggally - Pair Plot")


#pie------
pie(table(df$cyl), main='Base - Pie Plot')
ggplot(data = df, aes(x="", fill=cyl)) + geom_bar(stat='count', position='stack') + coord_polar("y") + ggtitle('ggplot - Pie Plot')



#clear plot area
hist(df$mpg)
graphics.off()

#and so on --------

