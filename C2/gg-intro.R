#ggplot system

library(ggplot2)
?ggplot

gplot(data = NULL, mapping = aes()))

#data - default dataset to use for plot : DF or converted to DF
#mapping - list of aesthetic mappings 

mtcars
df = mtcars  #make a copy of mtcars
str(df)
sapply(df, class)
#some columns can be made categorical
names(df)
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)
str(df)
sapply(df, class)

#now we can proceed with Visualisation

#methods of using ggplot
ggplot(data=df, mapping= aes(x=wt, y=mpg))  #nothing happens
plot(df$wt, df$mpg)   #base plot
ggplot(data=df, mapping= aes(x=wt, y=mpg)) + geom_point()  #points
ggplot(df, aes(x=wt, y=mpg)) + geom_point()  #make it shorter
ggplot(df, aes(x=wt, y=mpg)) + geom_point(color='red')
ggplot(df, aes(x=wt, y=mpg)) + geom_point(aes(color=carb))
ggplot(df, aes(x=wt, y=mpg)) + geom_point(aes(color=carb, size=hp))
ggplot(df, aes(x=wt, y=mpg)) + geom_point(aes(color=carb, size=hp, shape=am))
ggplot(df, aes(x=wt, y=mpg)) + geom_point(aes(color=carb, size=hp, shape=am))


