#ggplot - Bar Plot : Unused Level
#there is a category but no data: see changes required in Plotting

#categorical Variables
library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)
sapply(df, class)
ggplot(data=df, aes(x=gear, fill=gear)) + geom_bar()


#add unused levels
df2 = df
(df2$gear = as.character(df2$gear))
#as.numeric(as.character(df$factor_var))
df2$gear = factor(df2$gear, levels=c('3','4','5','6'))  #add 6th gear
(s2 <- df2 %>% group_by(cyl, gear) %>% summarise(n=n()))
table(df2$gear)
(gb4a <- ggplot(s2, aes(x=gear, y=n, fill=cyl)) + geom_bar(stat='identity', position='dodge') + scale_fill_discrete(drop=FALSE) + scale_x_discrete(drop=FALSE))
(gb4b <-  ggplot(s2, aes(x=gear, y=n, fill=cyl)) + geom_bar(stat='identity', position='dodge') + scale_fill_discrete(drop=TRUE) + scale_x_discrete(drop=TRUE))
gridExtra::grid.arrange(gb4a, gb4b)

table(df2$gear)
#maintain width levels from any bars  
ggplot(data = df2 , aes(x=gear, fill = gear)) + geom_bar(position = 'dodge')
ggplot(df, aes(x=gear, fill = vs)) +  geom_bar(position = position_dodge(preserve = "single"))
ggplot(df, aes(x=gear, fill = vs)) +  geom_bar(position = position_dodge(preserve = "single"))


(gb5a <- ggplot(df2, aes(x=gear, fill = cyl)) +  geom_bar(position = 'dodge'))  #see width of Gear 4 in Cyl 8 - wider
(gb5b <- ggplot(df2, aes(x=gear, fill = cyl)) +  geom_bar(position = position_dodge(preserve = "single")) + geom_text(stat='count', aes(label=..count..), position=position_dodge2(.6))) #width are equal
(gb5c <- ggplot(data = df2 %>% group_by(cyl, gear) %>% summarise(n=n()) , aes(x=gear, y=n , fill = cyl)) + geom_col(position = 'dodge'))
gridExtra::grid.arrange(gb6a, gb6b)

#remove any unused facet
(gb6a <- ggplot(s2, aes(x = cyl,y = n))  + geom_bar(stat='identity', position='dodge') + facet_grid( ~ gear,drop = FALSE) )
(gb6b <- ggplot(s2, aes(x = cyl,y = n))  + geom_bar(stat='identity', position='dodge') + facet_grid( ~ gear,drop = TRUE) )
#one facet removed
gridExtra::grid.arrange(gb6a, gb6b)


#Links
#https://stackoverflow.com/questions/45728723/ggplot2-dodge-overlapping-preserve-the-width-of-each-element

ggplot(df, aes(cyl, fill = vs)) +  geom_bar(position = "dodge")
with(df, table(cyl , vs ))  #convert table to DF
as.data.frame(with(df, table(cyl , vs )))  #Freq column added
ggplot(as.data.frame(with(df, table(cyl , vs ))),   aes(cyl, y = Freq, fill = vs)) +  geom_col(position = "dodge") +   scale_fill_discrete(drop = FALSE)


g7a <- ggplot(df2,aes(x = gear,fill = cyl)) 
g7a +   geom_bar(colour = "black",position = "dodge",stat = "count")
g7a +   geom_bar(colour = "black",position = position_dodge(preserve='single'),stat = "count")


#end here..._ta1