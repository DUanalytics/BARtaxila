#ggplot - Box Plot
#Continuous Values

library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)


#base
boxplot(df$mpg, notch=T)
boxplot(formula =  mpg ~ gear, data =df)
boxplot(formula =  mpg ~ gear, data =df, col=1:3)

?boxplot
ggplot(df, aes(x = "", y = mpg)) +  geom_boxplot()

ggplot(df, aes(x = "", y = mpg)) +  geom_boxplot(fill = 'red', colour = 'green') 

ggplot(df, aes(x = gear, y = mpg)) +  geom_boxplot(aes(fill=gear), colour = 'violet', width=.5) 

ggplot(df, aes(x = gear, y = mpg)) +  geom_boxplot(aes(fill=gear), colour = 'violet') 

ggplot(df, aes(x = "", y = mpg)) +  geom_violin()

ggplot(df, aes(x = "", y = mpg)) +  geom_violin(trim=FALSE)
ggplot(df, aes(x = gear, y = mpg)) +  geom_boxplot(aes(fill=gear)) + geom_violin(fill='yellow', alpha=.2) 

ggplot(df, aes(x = "", y = mpg)) + geom_boxplot(outlier.colour="red", outlier.shape=5, outlier.size=4, notch=T, fill='green') 
# confidence interval around the median which is normally based on the median +/- 1.58*IQR/sqrt(n). Notches are used to compare groups; if the notches of two boxes do not overlap, this is a strong evidence that the medians differ.
ggplot(df, aes(x = am, y = wt)) + geom_boxplot(outlier.colour="red", outlier.shape=5, outlier.size=4, notch=T, aes(fill=am))  + coord_flip()
#warning - It means that the confidence interval (i.e. size of the notches) is larger than the interquartile range (IQR). The size of the notches depends on your data: +/-1.58 IQR/sqrt(n)



#links
#http://www.sthda.com/english/wiki/ggplot2-violin-plot-quick-start-guide-r-software-and-data-visualization