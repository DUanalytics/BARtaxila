#ggplot : dot + box
#not working
#
library(ggplot2)
library(dplyr)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)


theme_set(theme_bw())

# plot
g <- ggplot(df, aes(x=cyl, y=mpg))
g + stat_boxplot(binwidth = 5) + geom_dotplot(binwidth = 5, stat='boxplot', stack='center', binaxis = 'y') 
?geom_boxplot
