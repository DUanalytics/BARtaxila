#ggplot - Bubble
library(dplyr)
library(ggplot2)

df=mtcars
#catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
#df[,catcols] = lapply(df[,catcols], as.factor)
#will not do this here

p=ggplot(df, aes(x=wt, y=mpg, size=gear)) + geom_point() 
p

p=ggplot(df, aes(x=wt, y=mpg, size=hp))
p1= p + geom_point(shape=21, colour='black', fill='cornsilk')
p1

p1 + scale_size_area(max_size=3)
p1 + scale_size_area(max_size=5)  #max size scale upto 5
p1 + scale_size_area(max_size=10)
p1 + scale_size_area(max_size=5, guide=F)  #no legend

#
ggplot(df, aes(x = wt, y = mpg, label = rownames(mtcars))) + geom_point(aes(size = gear, colour = cyl, alpha=.02)) +   geom_text(hjust = 1, size = 2) +  scale_size(range = c(1,5)) +  theme_bw()
#scaling with affect the aes for size and color

#to see overlapping points use jitter and alpha

#aes outside aes
(gb1 <- ggplot(df, aes(x = wt, y = mpg, label = rownames(df))) + geom_point(aes(size = gear, colour = factor(cyl)), alpha=.5) +  scale_size(range = c(1,5)))
gb1
(gb1 + geom_jitter() )
(gb1 + geom_text(hjust = 1, aes(size=am), vjust=1) +  theme_bw())
