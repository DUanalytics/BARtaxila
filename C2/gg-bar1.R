#ggplot - Bar Plot
#categorical Variables
library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

sapply(df, class)

#base
barplot(table(df$gear))

#ggplot
ggplot(data=df, aes(x=gear)) + geom_bar()

ggplot(data=df, aes(x=gear, fill=gear)) + geom_bar()
#barplots are of different types : horiz/vertical; stacked/dodge
ggplot(data=df, aes(x=gear, fill=gear)) + geom_bar() + coord_flip()

#stacked
ggplot(data=df, aes(x=gear, fill=cyl)) + geom_bar(position = position_stack()) + labs(title='Stacked Bar Plot')

#full rectange with % within gear
df %>% group_by(gear, cyl) %>% summarise(n=n())
(s1 <- df %>% group_by(gear, cyl) %>% summarise(n=n()) %>% mutate(perc = round(n/ sum(n, na.rm=T),2)))
s1 %>% group_by(gear) %>% summarise(sum(perc))  #this should be 1

ggplot(data=s1, aes(x=gear, y=perc, fill=cyl)) + geom_bar(stat='identity', position = position_stack()) + labs(title='Stacked Bar Plot')
#put labels also
ggplot(data=s1, aes(x=gear, y=perc, fill=cyl)) + geom_bar(stat='identity', position = position_stack()) + geom_text(aes(label=paste(perc*100,'%'), y=perc), position = position_stack()) +  labs(title='Stacked Bar Plot')


#dodge / side bars
gb2 <- ggplot(data=df, aes(x=gear, fill=cyl)) + geom_bar(stat='count', position = position_dodge2(.7)) 
gb2
gb2b <- geom_text(stat='count', aes(label=..count..), vjust=-1, position = position_dodge2(.7))
gb2 + gb2b

#using summary table
s1
gb3 <- ggplot(data=s1, aes(x=gear, y=n, fill=cyl)) + geom_bar(stat='identity', position = position_dodge2(.7)) + geom_text(stat='identity', aes(label=n, y=n), position = position_dodge2(.7))
gb3
gb3 + coord_flip()





#end here----------------------

#links
#http://t-redactyl.io/blog/2016/01/creating-plots-in-r-using-ggplot2-part-4-stacked-bar-plots.html
