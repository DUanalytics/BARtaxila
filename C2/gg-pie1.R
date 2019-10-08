#ggplot - Pie Plot
#categorical Variables

library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

sapply(df, class)

#base
table(df$cyl)
pie(table(df$cyl))
#other options for formatting...

#ggplot
#no option for drawing in pie avl in ggplot

ggplot(data=df, aes(x=cyl)) + geom_bar()
ggplot(data=df, aes(x=cyl)) + geom_bar()

ggplot(data=df, aes(x=cyl)) + geom_bar() + coord_polar(theta = "y")
#not good

(gearSum <- df %>% group_by(gear) %>% summarise(count=n()))

(gp1 <-ggplot(gearSum,  aes(x = "", fill= gear, y=count)) + geom_bar(stat='identity', width=1, position='stack' ))  #this is what we want
gp1 + coord_polar()
gp1 + coord_polar(theta = 'y')  #prop with y values : theta is angle

#another way: x=factor(1)
ggplot(df, aes(x=factor(1), fill=gear)) +   geom_bar(width = 1) + coord_polar("y")



#labelling is not easy
# Add label position
count.data <- df %>%  group_by(gear) %>% summarise(count = n()) %>% arrange(desc(count)) %>%   mutate(lab.ypos = cumsum(count) )
count.data
ggplot(count.data, aes(x = "", y = count, fill = gear)) +   geom_bar(width = 1, stat = "identity", color = "white") +  coord_polar("y", start = 0)+   geom_text(aes(y = lab.ypos, label = paste('gear-', gear, "::", count)), color = "black")+  theme_void()


#end here


#more options
# Basic pie charts
gearSum
ggpubr::ggpie(gearSum, x='count', label = 'gear', fill='gear')
                                                                                                                                                                