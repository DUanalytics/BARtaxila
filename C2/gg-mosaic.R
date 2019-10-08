#ggplot - Mosaic
#https://cran.r-project.org/web/packages/ggmosaic/vignettes/ggmosaic.html

#ggplot2 is not capable of handling a variable number of variables
library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

library(ggmosaic)
ggplot(data = df) +  geom_mosaic(aes(x = product(gear), fill=cyl), na.rm=TRUE) +  labs(x="Gear", y="Cylinders", title='Gear vs Cyl Cars') 
#looks like stacked bar plot without gaps
ggplot(data = df) + geom_bar(aes(x=gear, fill=cyl), stat='count', position = 'stack')


#------
ggplot(data = df) +  geom_mosaic(aes(x = product(gear, am), fill=cyl), na.rm=TRUE) + labs(x = "Gear", y="Cylinder", title='f(gear| am) f(cyl)')


#------
ggplot(data = df) +  geom_mosaic(aes(x = product(gear), fill=am), na.rm=TRUE) +  labs(x = "Gear", title='f(Gear|AM, Cyl | Carburator)') + facet_grid(carb ~ cyl)


gg