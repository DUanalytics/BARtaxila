#ggplot system

library(ggplot2)
?ggplot
#gplot(data = NULL, mapping = aes()))

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
ggplot(df, aes(x=wt, y=mpg)) + geom_point(color='red')  #color all points with red color
ggplot(df, aes(x=wt, y=mpg)) + geom_point(aes(color=carb)) 
#color as per levels of carb : different level mapped to different colors
levels(df$carb)
#--------
#color as per carb levels, size (numerical) - as Horspower values (auto scaling)
ggplot(df, aes(x=wt, y=mpg)) + geom_point(aes(color=carb, size=hp))
#add another aesthetic : shape mapped to levels of am
ggplot(df, aes(x=wt, y=mpg)) + geom_point(aes(color=carb, size=hp, shape=am))
#no more type of aesthetic for point type
ggplot(df, aes(x=wt, y=mpg)) + geom_point(aes(color=carb, size=hp, shape=am))

#facet
sapply(df, class)
ggplot(df, aes(x=wt, y=mpg)) + geom_point(aes(color=carb, size=hp, shape=am)) + facet_grid(vs ~ gear)
ggplot(df, aes(x=wt, y=mpg)) + geom_point(aes(color=carb, size=hp, shape=am)) + facet_grid(vs + cyl ~ gear)

#table and graph
library(gridExtra)
library(dplyr)
(table1 <- df %>% group_by(gear, cyl, am) %>% summarise(n=n()))
(graph1 <- ggplot(table1, aes(x=gear, y=n, fill=gear)) + geom_bar(stat='identity') + facet_grid(cyl ~ am))
grid.arrange(tableGrob(table1), graph1, ncol=2)
ggsave(filename='c2/g1.pdf')


#stepwise creation
g1 <- ggplot(df, aes(x=wt, y=mpg))
g1b <- g1 + geom_point(aes(color=carb))
g1b
g1c <- g1b + facet_grid(gear ~ cyl) 
g1c
(g1d <- g1b + facet_wrap(gear ~ cyl)) #wrap : missing box removed


#end here
#more - legend, different types of graphs and customising them

