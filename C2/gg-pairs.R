#gg plot Pairs Plot
#shows correlation between variables

#correlation plot
cor(women$height,women$weight)
pairs(women)
#is the relation between height and women + or - : Positive


#mtcars
numCols = c('mpg','wt','hp','disp')
df=mtcars
head(df[,numCols])
cor(df[,numCols])
pairs(df[,numCols])
df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

library("ggplot2")   
library("GGally")

ggpairs(df[,numCols])

ggpairs(df, columns = numCols, ggplot2::aes(colour=am))
